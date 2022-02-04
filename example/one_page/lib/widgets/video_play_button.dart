import 'package:flutter_next/flutter_next.dart';

class VideoPlayButton extends StatefulWidget {
  const VideoPlayButton({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoPlayButton> createState() => _VideoPlayButtonState();
}

class _VideoPlayButtonState extends State<VideoPlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController scaleController;
  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
        hoverDuration: const Duration(milliseconds: 500),
        builder: (context, isHovered) {
          if (isHovered) {
            scaleController.forward().then((value) {});
          } else {
            scaleController.reverse().then((value) {});
          }
          return SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                Positioned.fill(
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  )
                      .container(EdgeInsets.all(isHovered ? 30 : 18),
                          shouldAnimate: true)
                      .decoration(BoxDecoration(
                          shape: BoxShape.circle, color: context.primaryColor))
                      .container(EdgeInsets.all(isHovered ? 0 : 12),
                          shouldAnimate: true)
                      .decoration(BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.primaryColor.withOpacity(0.3)))
                      .center(),
                ),
                Positioned.fill(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: FadeTransition(
                      opacity:
                          Tween(begin: 1.0, end: 0.0).animate(scaleController),
                      child: ScaleTransition(
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                        scale: Tween(begin: 1.0, end: 20.0)
                            .animate(scaleController),
                      )),
                ))
              ],
            ),
          );
        });
  }
}
