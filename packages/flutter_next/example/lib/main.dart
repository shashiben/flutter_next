import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

void main() {
  runApp(const FlutterNextExample());
}

/// Layout follows the parent, not the window.
class FlutterNextExample extends StatelessWidget {
  /// Creates the example.
  const FlutterNextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Next',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LayoutStory(),
    );
  }
}

class LayoutStory extends StatefulWidget {
  const LayoutStory({super.key});

  @override
  State<LayoutStory> createState() => _LayoutStoryState();
}

class _LayoutStoryState extends State<LayoutStory> {
  double _frame = 720;
  int _replay = 0;

  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.sizeOf(context).width;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('The frame decides the layout')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final canResize = maxWidth.isFinite && maxWidth > 320;
          final frame = canResize
              ? _frame.clamp(280.0, maxWidth)
              : (maxWidth.isFinite ? maxWidth : 280.0);
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
            children: [
              Text(
                'A column reads the width of its parent. The window can be '
                '${breakpointForWidth(window).name} while this frame is something else.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Window ${window.toStringAsFixed(0)}px · '
                '${breakpointForWidth(window).name}'
                '    Frame ${frame.toStringAsFixed(0)}px',
              ),
              if (canResize)
                Slider(
                  min: 280,
                  max: maxWidth,
                  value: frame,
                  label: frame.toStringAsFixed(0),
                  onChanged: (value) => setState(() => _frame = value),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: scheme.outline),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    width: frame,
                    child: NextScope(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _FrameReadout(),
                            const SizedBox(height: 12),
                            const Text(
                              'NextSpan(xs: 12, md: 6, lg: 4)',
                              style: TextStyle(fontFamily: 'monospace'),
                            ),
                            const SizedBox(height: 8),
                            NextRow(
                              children: [
                                for (final label in ['One', 'Two', 'Three'])
                                  NextCol(
                                    span: const NextSpan(xs: 12, md: 6, lg: 4),
                                    child: _Cell(label: label),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'NextShow(from: lg) uses that same width.',
                            ),
                            const SizedBox(height: 8),
                            const NextShow(
                              from: Breakpoint.lg,
                              fallback: Text(
                                'Hidden until the frame reaches lg.',
                              ),
                              child: Text(
                                'Visible: this frame is lg or wider.',
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'A nested NextScope(gutter: 40) only changes its own subtree.',
                            ),
                            const SizedBox(height: 8),
                            const NextScope(
                              gutter: 40,
                              child: NextGrid(
                                span: NextSpan(xs: 6),
                                children: [
                                  _Cell(label: 'Wide gap'),
                                  _Cell(label: 'Wide gap'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonal(
                              onPressed: () => setState(() => _replay++),
                              child: const Text('Replay stagger'),
                            ),
                            const SizedBox(height: 8),
                            NextStagger(
                              key: ValueKey(_replay),
                              motion: NextMotion.fadeIn(NextFadeIn.fadeInUp),
                              children: const [
                                _Cell(label: 'First'),
                                _Cell(label: 'Then'),
                                _Cell(label: 'Last'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FrameReadout extends StatelessWidget {
  const _FrameReadout();

  @override
  Widget build(BuildContext context) {
    final size = const NextValue<double>(
      xs: 16,
      md: 22,
      lg: 32,
    ).resolve(context);
    final pad = const NextValue<double>(xs: 8, md: 16, lg: 28).resolve(context);
    return Padding(
      padding: EdgeInsets.all(pad),
      child: Text(
        'This frame is ${context.breakpoint.name}. '
        'Type ${size.toStringAsFixed(0)} · padding ${pad.toStringAsFixed(0)}.',
        style: TextStyle(fontSize: size, height: 1.2),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 64,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 8),
      color: scheme.primaryContainer,
      child: Text(label, style: TextStyle(color: scheme.onPrimaryContainer)),
    );
  }
}
