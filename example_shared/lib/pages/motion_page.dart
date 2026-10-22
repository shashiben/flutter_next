import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class MotionPage extends StatelessWidget {
  const MotionPage({super.key});

  @override
  Widget build(BuildContext context) => const _MotionBody();
}

class _MotionBody extends StatefulWidget {
  const _MotionBody();

  @override
  State<_MotionBody> createState() => _MotionBodyState();
}

class _MotionBodyState extends State<_MotionBody> {
  int _play = 0;
  bool _reduced = false;
  bool _warm = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final title = Theme.of(context).textTheme;
    return MediaQuery(
      data: media.copyWith(disableAnimations: _reduced),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
        children: [
          Text('Motion is one spec.', style: title.headlineSmall),
          const SizedBox(height: 8),
          const Text(
            'NextMotion describes the change. NextMotionView plays the curve '
            'after the delay. Reduced motion jumps to the end. NextStagger '
            'only adds a delay per child.',
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
                selected: _reduced,
                onSelected: (value) => setState(() => _reduced = value),
                label: const Text('Reduced motion'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text('Same fade, different curve.', style: title.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _CurveTile(
                key: ValueKey('linear-$_play'),
                label: 'linear',
                child: const _MotionBox(label: 'linear').fadeIn(
                  variant: NextFadeIn.fadeInUp,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 900),
                ),
              ),
              _CurveTile(
                key: ValueKey('easeIn-$_play'),
                label: 'easeIn',
                child: const _MotionBox(label: 'easeIn').fadeIn(
                  variant: NextFadeIn.fadeInUp,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 900),
                ),
              ),
              _CurveTile(
                key: ValueKey('delay-$_play'),
                label: 'default, after 500ms',
                child: const _MotionBox(label: 'wait').fadeIn(
                  variant: NextFadeIn.fadeInUp,
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text('Stagger only adds delay.', style: title.titleMedium),
          const SizedBox(height: 8),
          NextStagger(
            key: ValueKey(_play),
            motion: NextMotion.fadeIn(NextFadeIn.fadeInUp),
            children: const [
              NextSurface(child: Text('Plays the same fade')),
              NextSurface(child: Text('60ms later')),
              NextSurface(child: Text('120ms later')),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Each tile plays once when it scrolls into view.',
            style: title.titleMedium,
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
                    child: _MotionBox(label: 'Tile ${i + 1}').fadeIn(
                      variant: NextFadeIn.fadeInUp,
                      playWhenVisible: true,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'The color tween replays when the target changes.',
            style: title.titleMedium,
          ),
          const SizedBox(height: 8),
          NextColorTween(
            begin: Colors.indigo,
            end: _warm ? Colors.deepOrange : Colors.indigo,
            duration: const Duration(milliseconds: 500),
            builder: (context, color) {
              return Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => setState(() => _warm = !_warm),
                  child: Container(
                    width: 160,
                    height: 64,
                    alignment: Alignment.center,
                    color: color,
                    child: const Text(
                      'Tap',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CurveTile extends StatelessWidget {
  const _CurveTile({required this.label, required this.child, super.key});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _MotionBox extends StatelessWidget {
  const _MotionBox({required this.label});

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
