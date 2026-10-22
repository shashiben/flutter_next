import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../widgets/demo_frame.dart';

/// Layout follows the parent width.
class LayoutPage extends StatelessWidget {
  /// Creates the layout page.
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LayoutDemo();
  }
}

class _LayoutDemo extends StatefulWidget {
  const _LayoutDemo();

  @override
  State<_LayoutDemo> createState() => _LayoutDemoState();
}

class _LayoutDemoState extends State<_LayoutDemo> {
  double _frame = 720;

  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        final canResize = available.isFinite && available > 320;
        final frame = canResize
            ? _frame.clamp(280.0, available)
            : (available.isFinite ? available : 280.0);
        return ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
          children: [
            Text(
              'Layout follows the parent',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Columns measure the width of the widget that contains them. '
              'Drag the frame. The window breakpoint stays put.',
            ),
            const SizedBox(height: 16),
            Text(
              'Window ${window.toStringAsFixed(0)}px · '
              '${breakpointForWidth(window).name}',
            ),
            if (canResize)
              Slider(
                min: 280,
                max: available,
                value: frame,
                onChanged: (value) => setState(() => _frame = value),
              ),
            DemoFrame(
              width: frame,
              child: const NextScope(child: _FrameBody()),
            ),
          ],
        );
      },
    );
  }
}

class _FrameBody extends StatelessWidget {
  const _FrameBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Frame is ${context.breakpoint.name}.'),
        const SizedBox(height: 12),
        const Text(
          'NextSpan(xs: 12, md: 6, lg: 4)',
          style: TextStyle(fontFamily: 'monospace'),
        ),
        const SizedBox(height: 8),
        NextRow(
          children: [
            for (final label in const ['One', 'Two', 'Three'])
              NextCol(
                span: const NextSpan(xs: 12, md: 6, lg: 4),
                child: DemoCell(label: label),
              ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'A nested scope sets the gutter to 40 for this grid only. '
          'The default gutter is 16.',
        ),
        const SizedBox(height: 8),
        const NextScope(
          gutter: 40,
          child: NextGrid(
            span: NextSpan(xs: 6),
            children: [
              DemoCell(label: 'Wide gap'),
              DemoCell(label: 'Wide gap'),
            ],
          ),
        ),
      ],
    );
  }
}
