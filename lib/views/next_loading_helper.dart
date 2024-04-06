import 'package:flutter/material.dart';

class NextLoadingHelper extends StatelessWidget {
  const NextLoadingHelper(
      {super.key,
      required this.isLoading,
      this.ignoreWhileLoading = true,
      this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
      required this.child,
      this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
      this.switchOutCurve = Curves.linear,
      this.switchInCurve = Curves.linear,
      this.loadingWidget,
      this.duration = const Duration(milliseconds: 200),
      this.reverseDuration});

  ///isLoading--> true shows loading widget
  final bool isLoading;

  ///Main Child
  final Widget child;

  ///Provides custom loading widget
  final Widget? loadingWidget;

  /// If value is true the touches on child will be ignored
  final bool ignoreWhileLoading;

  /// The duration of the transition from the old [child] value to the new one.
  ///
  /// This duration is applied to the given [child] when that property is set to
  /// a new child. The same duration is used when fading out, unless
  /// [reverseDuration] is set. Changing [duration] will not affect the
  /// durations of transitions already in progress.
  final Duration duration;

  /// The duration of the transition from the new [child] value to the old one.
  ///
  /// This duration is applied to the given [child] when that property is set to
  /// a new child. Changing [reverseDuration] will not affect the durations of
  /// transitions already in progress.
  ///
  /// If not set, then the value of [duration] is used by default.
  final Duration? reverseDuration;

  /// The animation curve to use when transitioning in a new [child].
  ///
  /// This curve is applied to the given [child] when that property is set to a
  /// new child. Changing [switchInCurve] will not affect the curve of a
  /// transition already in progress.
  ///
  /// The [switchOutCurve] is used when fading out, except that if [child] is
  /// changed while the current child is in the middle of fading in,
  /// [switchInCurve] will be run in reverse from that point instead of jumping
  /// to the corresponding point on [switchOutCurve].
  final Curve switchInCurve;

  /// The animation curve to use when transitioning a previous [child] out.
  ///
  /// This curve is applied to the [child] when the child is faded in (or when
  /// the widget is created, for the first child). Changing [switchOutCurve]
  /// will not affect the curves of already-visible widgets, it only affects the
  /// curves of future children.
  ///
  /// If [child] is changed while the current child is in the middle of fading
  /// in, [switchInCurve] will be run in reverse from that point instead of
  /// jumping to the corresponding point on [switchOutCurve].
  final Curve switchOutCurve;

  /// A function that wraps a new [child] with an animation that transitions
  /// the [child] in when the animation runs in the forward direction and out
  /// when the animation runs in the reverse direction. This is only called
  /// when a new [child] is set (not for each build), or when a new
  /// [transitionBuilder] is set. If a new [transitionBuilder] is set, then
  /// the transition is rebuilt for the current child and all previous children
  /// using the new [transitionBuilder]. The function must not return null.
  ///
  /// The default is [AnimatedSwitcher.defaultTransitionBuilder].
  ///
  /// The animation provided to the builder has the [duration] and
  /// [switchInCurve] or [switchOutCurve] applied as provided when the
  /// corresponding [child] was first provided.
  ///
  /// See also:
  ///
  ///  * [AnimatedSwitcherTransitionBuilder] for more information about
  ///    how a transition builder should function.
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  /// A function that wraps all of the children that are transitioning out, and
  /// the [child] that's transitioning in, with a widget that lays all of them
  /// out. This is called every time this widget is built. The function must not
  /// return null.
  ///
  /// The default is [AnimatedSwitcher.defaultLayoutBuilder].
  ///
  /// See also:
  ///
  ///  * [AnimatedSwitcherLayoutBuilder] for more information about
  ///    how a layout builder should function.
  final AnimatedSwitcherLayoutBuilder layoutBuilder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: IgnorePointer(ignoring: ignoreWhileLoading, child: child)),
        AnimatedSwitcher(
            duration: duration,
            reverseDuration: reverseDuration,
            switchInCurve: switchInCurve,
            switchOutCurve: switchOutCurve,
            transitionBuilder: transitionBuilder,
            layoutBuilder: layoutBuilder,
            child: isLoading
                ? loadingWidget ??
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SizedBox(
                            height: 100,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              content: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Loading....',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                : const SizedBox())
      ],
    );
  }
}
