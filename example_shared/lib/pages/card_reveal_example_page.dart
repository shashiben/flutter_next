import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';

import '../widgets/code_block.dart';

class CardRevealExamplePage extends StatefulWidget {
  const CardRevealExamplePage({super.key});

  @override
  State<CardRevealExamplePage> createState() => _CardRevealExamplePageState();
}

class _CardRevealExamplePageState extends State<CardRevealExamplePage> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card Reveal Animation',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Flip card animation to reveal hidden content - perfect for games, rewards, and surprise reveals',
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
                    'Mystery Card',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRevealed = !_isRevealed;
                        });
                      },
                      child: NextFlipAnimation(
                        variant: _isRevealed
                            ? NextFlipVariant.flipOutX
                            : NextFlipVariant.flipInX,
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _isRevealed
                                  ? [
                                      Colors.purple.shade600,
                                      Colors.pink.shade600,
                                    ]
                                  : [
                                      Colors.blue.shade600,
                                      Colors.cyan.shade600,
                                    ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: _isRevealed
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const NextZoomAnimation(
                                        duration: Duration(milliseconds: 400),
                                        delay: Duration(milliseconds: 300),
                                        child: Icon(Icons.star,
                                            size: 64, color: Colors.white),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Congratulations!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'You found a special reward!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Colors.white
                                                  .withValues(alpha: 0.9),
                                            ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.help_outline,
                                          size: 64, color: Colors.white),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Tap to Reveal',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "What's inside?",
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.8),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      _isRevealed
                          ? 'Tap again to hide'
                          : 'Tap the card to reveal',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
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
bool _isRevealed = false;

GestureDetector(
  onTap: () => setState(() => _isRevealed = !_isRevealed),
  child: NextFlipAnimation(
    variant: _isRevealed 
        ? NextFlipVariant.flipOutX 
        : NextFlipVariant.flipInX,
    duration: Duration(milliseconds: 600),
    child: Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(...),
        borderRadius: BorderRadius.circular(16),
      ),
      child: _isRevealed 
          ? RevealedContent() 
          : HiddenContent(),
    ),
  ),
)''',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
