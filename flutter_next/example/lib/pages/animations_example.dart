import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';

class AnimationsExamplePage extends StatefulWidget {
  const AnimationsExamplePage({super.key});

  @override
  State<AnimationsExamplePage> createState() => _AnimationsExamplePageState();
}

class _AnimationsExamplePageState extends State<AnimationsExamplePage>
    with TickerProviderStateMixin {
  int _notificationCount = 0;
  int _score = 0;
  int _selectedCard = -1;
  late final List<AnimationController> _bounceControllers;
  late final List<AnimationController> _fadeControllers;
  late final List<AnimationController> _slideControllers;
  late final List<AnimationController> _zoomControllers;
  late final List<AnimationController> _flipControllers;

  @override
  void initState() {
    super.initState();
    
    // Initialize bounce controllers (6 items)
    _bounceControllers = List.generate(
      6,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      )..forward(),
    );
    
    // Initialize fade controllers (max 5 notifications)
    _fadeControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );
    
    // Initialize slide controllers (5 cards) - start fully visible
    _slideControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      )..value = 1.0,
    );
    
    // Initialize zoom controllers (5 images) - start fully visible
    _zoomControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      )..value = 1.0,
    );
    
    // Initialize flip controllers (6 cards)
    _flipControllers = List.generate(
      6,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in [
      ..._bounceControllers,
      ..._fadeControllers,
      ..._slideControllers,
      ..._zoomControllers,
      ..._flipControllers,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Interactive Animations'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Hero Section - Bounce Animation
            _buildSectionTitle(context, 'Bounce Animations', Icons.sports_esports),
            _buildBounceGame(context),

            const SizedBox(height: 32),

            // Notification System - Fade Animations
            _buildSectionTitle(context, 'Fade Animations', Icons.notifications),
            _buildNotificationSystem(context),

            const SizedBox(height: 32),

            // Card Stack - Slide Animations
            _buildSectionTitle(context, 'Slide Animations', Icons.style),
            _buildCardStack(context),

            const SizedBox(height: 32),

            // Zoom Gallery
            _buildSectionTitle(context, 'Zoom Animations', Icons.photo_library),
            _buildZoomGallery(context),

            const SizedBox(height: 32),

            // Flip Card Game
            _buildSectionTitle(context, 'Flip Animations', Icons.casino),
            _buildFlipCardGame(context),

            const SizedBox(height: 32),

            // Color Mood Changer
            _buildSectionTitle(context, 'Color Tween', Icons.palette),
            _buildColorMoodChanger(context),

            const SizedBox(height: 32),

            // Combined Animation Showcase
            _buildSectionTitle(context, 'Combined Animations', Icons.auto_awesome),
            _buildCombinedShowcase(context),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Bounce Game - Interactive bouncing targets
  Widget _buildBounceGame(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        children: [
          Text(
            '🎯 Tap the targets to bounce them! Score: $_score',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(6, (index) {
              final controller = _bounceControllers[index];

              return GestureDetector(
                onTap: () {
                  controller.reset();
                  controller.forward();
                  setState(() => _score++);
                },
                child: NextBounceAnimation(
                  controller: controller,
                  autoStart: false,
                  variant: NextBounceVariant.values[index % 4],
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: [
                        Colors.red,
                        Colors.blue,
                        Colors.green,
                        Colors.purple,
                        Colors.teal,
                        Colors.pink,
                      ][index],
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => setState(() => _score = 0),
            icon: const Icon(Icons.refresh),
            label: const Text('Reset Score'),
          ),
        ],
      ),
    );
  }

  // Notification System - Fade in/out notifications
  Widget _buildNotificationSystem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '🔔 Notifications: $_notificationCount',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _notificationCount++);
                },
                icon: const Icon(Icons.add_alert),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(
            _notificationCount.clamp(0, 5),
            (index) {
              final controller = _fadeControllers[index];
              // Start animation if controller is at initial state
              if (!controller.isAnimating) {
                if (controller.value == 1.0) {
                  controller.reset();
                }
                if (controller.value == 0) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (controller.value == 0 && !controller.isAnimating) {
                      controller.forward();
                    }
                  });
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: NextFadeInAnimation(
                  controller: controller,
                  autoStart: false,
                  variant: NextFadeInVariant.values[index % 4],
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'New notification #${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            controller.reverse().then((_) {
                              setState(() => _notificationCount--);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (_notificationCount == 0)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No notifications. Tap "Add" to create one!',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  // Card Stack - Sliding cards
  Widget _buildCardStack(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          const Text(
            '📚 Swipe through the card stack!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: Stack(
              children: List.generate(5, (index) {
                final controller = _slideControllers[index];

                return Positioned(
                  left: index * 8.0,
                  top: index * 8.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_selectedCard == index) {
                        // Reset and animate forward for bounce effect
                        controller.reset();
                        controller.forward();
                      } else {
                        setState(() => _selectedCard = index);
                      }
                    },
                    child: NextSlideAnimation(
                      controller: controller,
                      autoStart: false,
                      variant: NextSlideVariant.values[index % 4],
                      duration: const Duration(milliseconds: 800),
                      child: Transform.scale(
                        scale: _selectedCard == index ? 1.05 : 1.0,
                        child: Container(
                          width: 150,
                          height: 200,
                          decoration: BoxDecoration(
                            color: [
                              Colors.red.shade400,
                              Colors.blue.shade400,
                              Colors.purple.shade400,
                              Colors.orange.shade400,
                              Colors.teal.shade400,
                            ][index],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Card ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Zoom Gallery - Interactive image gallery
  Widget _buildZoomGallery(BuildContext context) {
    final images = [
      Icons.landscape,
      Icons.beach_access,
      Icons.nightlife,
      Icons.location_city,
      Icons.forest,
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          const Text(
            '🖼️ Tap images to zoom in/out!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(images.length, (index) {
              final controller = _zoomControllers[index];

              return GestureDetector(
                onTap: () async{
                  // Reset and animate forward for zoom in effect
                  controller.reset();
                  await controller.forward();
                },
                child: NextZoomAnimation(
                  controller: controller,
                  autoStart: false,
                  variant: NextZoomVariant.zoomIn,
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade300,
                          Colors.pink.shade300,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      images[index],
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Flip Card Game - Memory game style
  Widget _buildFlipCardGame(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        children: [
          const Text(
            '🎴 Flip the cards to reveal!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(6, (index) {
              final controller = _flipControllers[index];

              return GestureDetector(
                onTap: () {
                  if (controller.isCompleted) {
                    controller.reverse();
                  } else {
                    controller.forward();
                  }
                },
                child: NextFlipAnimation(
                  controller: controller,
                  autoStart: false,
                  variant: index % 2 == 0 ? NextFlipVariant.flipX : NextFlipVariant.flipY,
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    width: 80,
                    height: 120,
                    decoration: BoxDecoration(
                      color: controller.isCompleted
                          ? Colors.white
                          : Colors.teal.shade400,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.teal.shade600,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: controller.isCompleted
                        ? Center(
                            child: Icon(
                              [
                                Icons.star,
                                Icons.favorite,
                                Icons.diamond,
                                Icons.bolt,
                                Icons.celebration,
                                Icons.rocket,
                              ][index],
                              size: 40,
                              color: Colors.teal.shade400,
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.question_mark,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Color Mood Changer - Interactive color transitions
  Widget _buildColorMoodChanger(BuildContext context) {
    final moods = [
      {'name': 'Happy', 'color': Colors.yellow, 'icon': Icons.sentiment_very_satisfied},
      {'name': 'Calm', 'color': Colors.blue, 'icon': Icons.water_drop},
      {'name': 'Energetic', 'color': Colors.orange, 'icon': Icons.bolt},
      {'name': 'Peaceful', 'color': Colors.green, 'icon': Icons.spa},
      {'name': 'Romantic', 'color': Colors.pink, 'icon': Icons.favorite},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        children: [
          const Text(
            '🎨 Change your mood with colors!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: moods.map((mood) {
              return NextColorTweenWidget(
                beginColor: Colors.grey.shade300,
                endColor: mood['color'] as Color,
                duration: const Duration(milliseconds: 800),
                child: (controller, color) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.isCompleted) {
                        controller.reverse();
                      } else {
                        controller.forward();
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            mood['icon'] as IconData,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            mood['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Combined Animation Showcase
  Widget _buildCombinedShowcase(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.pink.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '✨ Combined Animation Magic!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          NextFadeInAnimation(
            variant: NextFadeInVariant.fadeInTop,
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            child: NextSlideAnimation(
              variant: NextSlideVariant.slideInTop,
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: NextZoomAnimation(
                variant: NextZoomVariant.zoomIn,
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'All animations working together!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Fade + Slide + Zoom',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
