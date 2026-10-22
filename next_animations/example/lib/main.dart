import 'package:flutter/material.dart';
import 'package:next_animations/next_animations.dart';

void main() {
  runApp(const NextAnimationsExample());
}

/// One spec, one player.
class NextAnimationsExample extends StatelessWidget {
  /// Creates the example.
  const NextAnimationsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'next_animations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MotionStory(),
    );
  }
}

class MotionStory extends StatefulWidget {
  const MotionStory({super.key});

  @override
  State<MotionStory> createState() => _MotionStoryState();
}

class _MotionStoryState extends State<MotionStory> {
  int _play = 0;
  bool _reduced = false;
  bool _warm = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return MediaQuery(
      data: media.copyWith(disableAnimations: _reduced),
      child: Scaffold(
        appBar: AppBar(title: const Text('One motion, then play it')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
          children: [
            Text(
              'NextMotion is the change. NextMotionView plays it. '
              'The curve and the delay are on that timeline. '
              'Reduced motion jumps to the end.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FilledButton(
                  onPressed: () => setState(() => _play++),
                  child: const Text('Play again'),
                ),
                FilterChip(
                  label: const Text('Reduced motion'),
                  selected: _reduced,
                  onSelected: (value) => setState(() => _reduced = value),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Same fade. Different curve and delay.'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _Tile(
                  key: ValueKey('linear-$_play'),
                  label: 'linear',
                  child: const _Box(label: 'linear').fadeIn(
                    variant: NextFadeIn.fadeInUp,
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 900),
                  ),
                ),
                _Tile(
                  key: ValueKey('ease-$_play'),
                  label: 'easeIn',
                  child: const _Box(label: 'easeIn').fadeIn(
                    variant: NextFadeIn.fadeInUp,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 900),
                  ),
                ),
                _Tile(
                  key: ValueKey('wait-$_play'),
                  label: 'easeOut, after 500ms',
                  child: const _Box(label: 'wait').fadeIn(
                    variant: NextFadeIn.fadeInUp,
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text('Scroll sideways. Each tile plays once when it appears.'),
            const SizedBox(height: 8),
            SizedBox(
              height: 72,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < 8; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: _Box(label: 'Tile ${i + 1}').fadeIn(
                        variant: NextFadeIn.fadeInUp,
                        playWhenVisible: true,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text('NextColorTween replays when the target color changes.'),
            const SizedBox(height: 8),
            NextColorTween(
              begin: Colors.indigo,
              end: _warm ? Colors.deepOrange : Colors.indigo,
              duration: const Duration(milliseconds: 500),
              builder: (context, color) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => setState(() => _warm = !_warm),
                      borderRadius: BorderRadius.circular(12),
                      child: const SizedBox(
                        width: 160,
                        height: 72,
                        child: Center(
                          child: Text(
                            'Tap',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label, required this.child, super.key});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 160,
      height: 64,
      alignment: Alignment.center,
      color: scheme.primaryContainer,
      child: Text(label, style: TextStyle(color: scheme.onPrimaryContainer)),
    );
  }
}
