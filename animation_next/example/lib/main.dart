import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationNextExample());
}

/// One spec, one player.
class AnimationNextExample extends StatelessWidget {
  /// Creates the example.
  const AnimationNextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animation_next',
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
            const Text(
              'Scroll sideways. Each tile plays once when it appears.',
            ),
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
            const Text(
              'Compose a list. A spring plays unless you pass a curve.',
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 16,
              children: [
                _kind('fade', const [
                  NextFade(to: 1, initial: 0, duration: _span),
                ]),
                _kind('move', const [
                  NextMove(y: 0, initialY: 28, duration: _span),
                ]),
                _kind('scale', const [
                  NextScale(
                    by: 1,
                    initial: 0.4,
                    spring: NextSpring.bouncy,
                    duration: _span,
                  ),
                ]),
                _kind('rotate', const [
                  NextRotate(degrees: 0, initial: -16, duration: _span),
                ]),
                _kind('skew', const [
                  NextSkew(x: 0, initialX: 14, duration: _span),
                ]),
                _kind('size', const [
                  NextSize(
                    width: 140,
                    initialWidth: 48,
                    height: 64,
                    initialHeight: 64,
                    duration: _span,
                  ),
                ]),
                _kind('blur', const [
                  NextBlur(to: 0, initial: 6, duration: _span),
                ]),
                _kind('tint', const [
                  NextTint(
                    to: Color(0x00000000),
                    initial: Color(0x99E65100),
                    duration: _span,
                  ),
                ]),
                _kind('radius', const [
                  NextRadius(to: 28, initial: 0, duration: _span),
                ]),
                _kind('reveal', const [NextReveal(duration: _span)]),
                _kind('shadow', const [
                  NextShadow(
                    to: BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                    duration: _span,
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 28),
            const Text('Same move. Four springs.'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 16,
              children: [
                for (final spring in const [
                  (NextSpring.smooth, 'smooth'),
                  (NextSpring.gentle, 'gentle'),
                  (NextSpring.snappy, 'snappy'),
                  (NextSpring.bouncy, 'bouncy'),
                ])
                  _Tile(
                    key: ValueKey('${spring.$2}-$_play'),
                    label: spring.$2,
                    child: _Box(label: spring.$2).animate([
                      NextMove(
                        y: 0,
                        initialY: 24,
                        spring: spring.$1,
                        duration: const Duration(milliseconds: 900),
                      ),
                    ]),
                  ),
              ],
            ),
            const SizedBox(height: 28),
            const Text('Chained, looping, and reversing.'),
            const SizedBox(height: 8),
            const _Box(label: 'chain').animate(
              const [
                NextFade(to: 1, initial: 0),
                NextMove(y: 0, initialY: 24),
                NextScale(by: 1, initial: 0.9),
                NextBlur(to: 0, initial: 6),
                NextMove(x: 28, start: Duration(milliseconds: 600)),
                NextFade(
                  to: 0.4,
                  start: Duration(milliseconds: 1200),
                  duration: Duration(milliseconds: 400),
                ),
              ],
              repeat: NextAnimated.forever,
              reverse: true,
              alignment: Alignment.bottomLeft,
              key: ValueKey('chain-$_play'),
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

  Widget _kind(String label, List<NextAnimation> animations) {
    return _Tile(
      key: ValueKey('$label-$_play'),
      label: label,
      child: _Box(label: label).animate(animations),
    );
  }
}

const _span = Duration(milliseconds: 700);

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
