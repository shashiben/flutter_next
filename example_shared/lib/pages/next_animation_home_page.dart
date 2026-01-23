import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class NextAnimationHomePage extends StatefulWidget {
  const NextAnimationHomePage({super.key});

  @override
  State<NextAnimationHomePage> createState() => _NextAnimationHomePageState();
}

class _NextAnimationHomePageState extends State<NextAnimationHomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with back button
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/'),
              ),
              Expanded(
                child: Text(
                  'Next Animation',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Just-add-water Flutter animations',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 48),

          // Animation Categories
          _AnimationCategory(
            title: 'Bouncing Entrances',
            animations: [
              _AnimationItem(
                name: 'bounceIn',
                variant: NextBounceVariant.bounceIn,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceInDown',
                variant: NextBounceVariant.bounceInBottom,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceInLeft',
                variant: NextBounceVariant.bounceInLeft,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceInRight',
                variant: NextBounceVariant.bounceInRight,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceInUp',
                variant: NextBounceVariant.bounceInTop,
                type: _AnimationType.bounce,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Bouncing Exits',
            animations: [
              _AnimationItem(
                name: 'bounceOut',
                variant: NextBounceVariant.bounceOut,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceOutDown',
                variant: NextBounceVariant.bounceOutBottom,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceOutLeft',
                variant: NextBounceVariant.bounceOutLeft,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceOutRight',
                variant: NextBounceVariant.bounceOutRight,
                type: _AnimationType.bounce,
              ),
              _AnimationItem(
                name: 'bounceOutUp',
                variant: NextBounceVariant.bounceOutTop,
                type: _AnimationType.bounce,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Fading Entrances',
            animations: [
              _AnimationItem(
                name: 'fadeIn',
                variant: NextFadeInVariant.fadeIn,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInDown',
                variant: NextFadeInVariant.fadeInDownBig,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInDownBig',
                variant: NextFadeInVariant.fadeInDownBig,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInLeft',
                variant: NextFadeInVariant.fadeInLeft,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInLeftBig',
                variant: NextFadeInVariant.fadeInLeftBig,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInRight',
                variant: NextFadeInVariant.fadeInRight,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInRightBig',
                variant: NextFadeInVariant.fadeInRightBig,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInUp',
                variant: NextFadeInVariant.fadeInUpBig,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInUpBig',
                variant: NextFadeInVariant.fadeInUpBig,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInTopLeft',
                variant: NextFadeInVariant.fadeInTopLeft,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInTopRight',
                variant: NextFadeInVariant.fadeInTopRight,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInBottomLeft',
                variant: NextFadeInVariant.fadeInBottomLeft,
                type: _AnimationType.fadeIn,
              ),
              _AnimationItem(
                name: 'fadeInBottomRight',
                variant: NextFadeInVariant.fadeInBottomRight,
                type: _AnimationType.fadeIn,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Fading Exits',
            animations: [
              _AnimationItem(
                name: 'fadeOut',
                variant: NextFadeOutVariant.fadeOut,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutDown',
                variant: NextFadeOutVariant.fadeOutDownBig,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutDownBig',
                variant: NextFadeOutVariant.fadeOutDownBig,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutLeft',
                variant: NextFadeOutVariant.fadeOutLeft,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutLeftBig',
                variant: NextFadeOutVariant.fadeOutLeftBig,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutRight',
                variant: NextFadeOutVariant.fadeOutRight,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutRightBig',
                variant: NextFadeOutVariant.fadeOutRightBig,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutUp',
                variant: NextFadeOutVariant.fadeOutUpBig,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutUpBig',
                variant: NextFadeOutVariant.fadeOutUpBig,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutTopLeft',
                variant: NextFadeOutVariant.fadeOutTopLeft,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutTopRight',
                variant: NextFadeOutVariant.fadeOutTopRight,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutBottomLeft',
                variant: NextFadeOutVariant.fadeOutBottomLeft,
                type: _AnimationType.fadeOut,
              ),
              _AnimationItem(
                name: 'fadeOutBottomRight',
                variant: NextFadeOutVariant.fadeOutBottomRight,
                type: _AnimationType.fadeOut,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Flippers',
            animations: [
              _AnimationItem(
                name: 'flipInX',
                variant: NextFlipVariant.flipInX,
                type: _AnimationType.flip,
              ),
              _AnimationItem(
                name: 'flipInY',
                variant: NextFlipVariant.flipInY,
                type: _AnimationType.flip,
              ),
              _AnimationItem(
                name: 'flipOutX',
                variant: NextFlipVariant.flipOutX,
                type: _AnimationType.flip,
              ),
              _AnimationItem(
                name: 'flipOutY',
                variant: NextFlipVariant.flipOutY,
                type: _AnimationType.flip,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Sliding Entrances',
            animations: [
              _AnimationItem(
                name: 'slideInDown',
                variant: NextSlideVariant.slideInTop,
                type: _AnimationType.slide,
              ),
              _AnimationItem(
                name: 'slideInLeft',
                variant: NextSlideVariant.slideInLeft,
                type: _AnimationType.slide,
              ),
              _AnimationItem(
                name: 'slideInRight',
                variant: NextSlideVariant.slideInRight,
                type: _AnimationType.slide,
              ),
              _AnimationItem(
                name: 'slideInUp',
                variant: NextSlideVariant.slideInBottom,
                type: _AnimationType.slide,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Sliding Exits',
            animations: [
              _AnimationItem(
                name: 'slideOutDown',
                variant: NextSlideVariant.slideOutTop,
                type: _AnimationType.slide,
              ),
              _AnimationItem(
                name: 'slideOutLeft',
                variant: NextSlideVariant.slideOutLeft,
                type: _AnimationType.slide,
              ),
              _AnimationItem(
                name: 'slideOutRight',
                variant: NextSlideVariant.slideOutRight,
                type: _AnimationType.slide,
              ),
              _AnimationItem(
                name: 'slideOutUp',
                variant: NextSlideVariant.slideOutBottom,
                type: _AnimationType.slide,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Zooming Entrances',
            animations: [
              _AnimationItem(
                name: 'zoomIn',
                variant: NextZoomVariant.zoomIn,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomInDown',
                variant: NextZoomVariant.zoomInDown,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomInLeft',
                variant: NextZoomVariant.zoomInLeft,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomInRight',
                variant: NextZoomVariant.zoomInRight,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomInUp',
                variant: NextZoomVariant.zoomInUp,
                type: _AnimationType.zoom,
              ),
            ],
          ),
          const SizedBox(height: 32),

          _AnimationCategory(
            title: 'Zooming Exits',
            animations: [
              _AnimationItem(
                name: 'zoomOut',
                variant: NextZoomVariant.zoomOut,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomOutDown',
                variant: NextZoomVariant.zoomOutDown,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomOutLeft',
                variant: NextZoomVariant.zoomOutLeft,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomOutRight',
                variant: NextZoomVariant.zoomOutRight,
                type: _AnimationType.zoom,
              ),
              _AnimationItem(
                name: 'zoomOutUp',
                variant: NextZoomVariant.zoomOutUp,
                type: _AnimationType.zoom,
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Examples Section
          Text(
            'Real-World Examples',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Practical examples showing how to use animations in real apps',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 24),
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _ExampleCard(
                title: 'Dropdown',
                description: 'Expandable dropdown with slide animation',
                icon: Icons.arrow_drop_down,
                route: '/dropdown-example',
              ),
              _ExampleCard(
                title: 'Modal',
                description: 'Dialog with zoom-in animation',
                icon: Icons.open_in_new,
                route: '/modal-example',
              ),
              _ExampleCard(
                title: 'List',
                description: 'Task list with sequential fade-in',
                icon: Icons.list,
                route: '/list-example',
              ),
              _ExampleCard(
                title: 'Button',
                description: 'Button with bounce feedback',
                icon: Icons.touch_app,
                route: '/button-example',
              ),
              _ExampleCard(
                title: 'Card Reveal',
                description: 'Flip card to reveal content',
                icon: Icons.flip,
                route: '/card-reveal-example',
              ),
              _ExampleCard(
                title: 'Search',
                description: 'Expandable search bar',
                icon: Icons.search,
                route: '/search-example',
              ),
              _ExampleCard(
                title: 'Tab',
                description: 'Tab switching with fade',
                icon: Icons.tab,
                route: '/tab-example',
              ),
            ],
          ),
          const SizedBox(height: 48),

          // Footer
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documentation',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Next Animation is a library of ready-to-use, cross-platform animations for use in your Flutter projects. Great for emphasis, home pages, sliders, and attention-guiding hints.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

enum _AnimationType {
  bounce,
  fadeIn,
  fadeOut,
  flip,
  slide,
  zoom,
}

class _AnimationItem {
  _AnimationItem({
    required this.name,
    required this.variant,
    required this.type,
  });
  final String name;
  final dynamic variant;
  final _AnimationType type;
}

class _AnimationCategory extends StatelessWidget {
  const _AnimationCategory({
    required this.title,
    required this.animations,
  });
  final String title;
  final List<_AnimationItem> animations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children:
              animations.map((item) => _AnimationCard(item: item)).toList(),
        ),
      ],
    );
  }
}

class _AnimationCard extends StatefulWidget {
  const _AnimationCard({required this.item});
  final _AnimationItem item;

  @override
  State<_AnimationCard> createState() => _AnimationCardState();
}

class _AnimationCardState extends State<_AnimationCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _showCopied = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final duration = widget.item.type == _AnimationType.bounce
        ? const Duration(milliseconds: 1000)
        : const Duration(milliseconds: 800);
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replayAnimation() {
    _controller.reset();
    _controller.forward();
  }

  void _copyToClipboard() {
    final code = widget.item.name;
    Clipboard.setData(ClipboardData(text: code));
    setState(() {
      _showCopied = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        elevation: _isHovered ? 4 : 1,
        child: InkWell(
          onTap: _replayAnimation,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: _buildAnimationDemo(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.item.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'monospace',
                          ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _copyToClipboard();
                      },
                      child: Icon(
                        _showCopied ? Icons.check : Icons.copy,
                        size: 16,
                        color: _showCopied
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationDemo() {
    switch (widget.item.type) {
      case _AnimationType.bounce:
        return NextBounceAnimation(
          controller: _controller,
          variant: widget.item.variant as NextBounceVariant,
          autoStart: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      case _AnimationType.fadeIn:
        return NextFadeInAnimation(
          controller: _controller,
          variant: widget.item.variant as NextFadeInVariant?,
          autoStart: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      case _AnimationType.fadeOut:
        return NextFadeOutAnimation(
          controller: _controller,
          variant: widget.item.variant as NextFadeOutVariant?,
          autoStart: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      case _AnimationType.flip:
        return NextFlipAnimation(
          controller: _controller,
          variant: widget.item.variant as NextFlipVariant,
          autoStart: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      case _AnimationType.slide:
        return NextSlideAnimation(
          controller: _controller,
          variant: widget.item.variant as NextSlideVariant,
          autoStart: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      case _AnimationType.zoom:
        return NextZoomAnimation(
          controller: _controller,
          variant: widget.item.variant as NextZoomVariant,
          autoStart: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
    }
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });
  final String title;
  final String description;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => context.go(route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'View Example',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
