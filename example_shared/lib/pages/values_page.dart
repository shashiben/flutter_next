import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../widgets/demo_frame.dart';

class ValuesPage extends StatelessWidget {
  const ValuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ValuesDemo();
  }
}

class _ValuesDemo extends StatefulWidget {
  const _ValuesDemo();

  @override
  State<_ValuesDemo> createState() => _ValuesDemoState();
}

class _ValuesDemoState extends State<_ValuesDemo> {
  double _frame = 720;

  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(
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
              'The same cascade, for anything.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'NextValue, NextShow, and NextSurface read the parent width.',
            ),
            const SizedBox(height: 12),
            Text(
              'Window ${window.toStringAsFixed(0)}px · '
              '${breakpointForWidth(window).name}',
            ),
            if (canResize)
              Slider(
                min: 280,
                max: maxWidth,
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
    final size = const NextValue<double>(
      xs: 16,
      md: 22,
      lg: 30,
    ).resolve(context);
    final pad = const NextValue<double>(xs: 8, md: 16, lg: 28).resolve(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(pad),
          child: Text(
            'Frame ${context.breakpoint.name} · ${size.toStringAsFixed(0)}.',
            style: TextStyle(fontSize: size, height: 1.2),
          ),
        ),
        const SizedBox(height: 12),
        const NextShow(
          from: Breakpoint.lg,
          fallback: Text('Hidden until the frame is lg.'),
          child: Text('Visible because this frame is lg or wider.'),
        ),
        const SizedBox(height: 12),
        const NextGrid(
          span: NextSpan(xs: 12, md: 6),
          children: [
            NextSurface(variant: NextVariant.primary, child: Text('Primary')),
            NextSurface(variant: NextVariant.success, child: Text('Success')),
            NextSurface(variant: NextVariant.warning, child: Text('Warning')),
          ],
        ),
      ],
    );
  }
}
