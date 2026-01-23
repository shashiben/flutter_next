import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';

import '../widgets/code_block.dart';

class ButtonExamplePage extends StatefulWidget {
  const ButtonExamplePage({super.key});

  @override
  State<ButtonExamplePage> createState() => _ButtonExamplePageState();
}

class _ButtonExamplePageState extends State<ButtonExamplePage> {
  int _likes = 42;
  bool _isLiked = false;
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Button Animation',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Interactive buttons with bounce feedback - perfect for likes, follows, and action buttons',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 48),

          // Live Example
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Social Media Post',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  // Post Content
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child:
                                  const Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    '2 hours ago',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey.shade600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Just shipped a new feature! 🚀 Check out the latest updates in our app.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Action Buttons
                  Row(
                    children: [
                      _AnimatedLikeButton(
                        isLiked: _isLiked,
                        count: _likes,
                        onPressed: () {
                          setState(() {
                            _isLiked = !_isLiked;
                            _likes += _isLiked ? 1 : -1;
                          });
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AnimatedFollowButton(
                          isFollowing: _isFollowing,
                          onPressed: () {
                            setState(() {
                              _isFollowing = !_isFollowing;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Code Example
          Text(
            'Code Example',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CodeBlock(
                code: '''
class _AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  
  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _handleTap() {
    _controller.reset();
    _controller.forward();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return NextBounceAnimation(
      controller: _controller,
      variant: NextBounceVariant.bounceIn,
      duration: Duration(milliseconds: 300),
      autoStart: false,
      child: FilledButton(
        onPressed: _handleTap,
        child: Text('Button'),
      ),
    );
  }
}''',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedLikeButton extends StatefulWidget {
  const _AnimatedLikeButton({
    required this.isLiked,
    required this.count,
    required this.onPressed,
  });
  final bool isLiked;
  final int count;
  final VoidCallback onPressed;

  @override
  State<_AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<_AnimatedLikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.reset();
    _controller.forward();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return NextBounceAnimation(
      controller: _controller,
      variant: NextBounceVariant.bounceIn,
      duration: const Duration(milliseconds: 300),
      autoStart: false,
      child: FilledButton.icon(
        onPressed: _handleTap,
        icon: Icon(
          widget.isLiked ? Icons.favorite : Icons.favorite_border,
          color: widget.isLiked ? Colors.red : null,
        ),
        label: Text('${widget.count}'),
        style: FilledButton.styleFrom(
          backgroundColor: widget.isLiked
              ? Colors.red.shade50
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          foregroundColor: widget.isLiked ? Colors.red : null,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}

class _AnimatedFollowButton extends StatefulWidget {
  const _AnimatedFollowButton({
    required this.isFollowing,
    required this.onPressed,
  });
  final bool isFollowing;
  final VoidCallback onPressed;

  @override
  State<_AnimatedFollowButton> createState() => _AnimatedFollowButtonState();
}

class _AnimatedFollowButtonState extends State<_AnimatedFollowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.reset();
    _controller.forward();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return NextBounceAnimation(
      controller: _controller,
      variant: NextBounceVariant.bounceIn,
      duration: const Duration(milliseconds: 300),
      autoStart: false,
      child: widget.isFollowing
          ? OutlinedButton.icon(
              onPressed: _handleTap,
              icon: const Icon(Icons.check),
              label: const Text('Following'),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            )
          : FilledButton.icon(
              onPressed: _handleTap,
              icon: const Icon(Icons.person_add),
              label: const Text('Follow'),
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
    );
  }
}
