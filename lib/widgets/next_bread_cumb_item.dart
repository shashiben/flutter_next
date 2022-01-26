import '../flutter_next.dart';

class NextBreadCumbItem extends StatelessWidget {
  final Widget Function(bool isHovered) child;
  const NextBreadCumbItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
        builder: (_, isHovered) => child(
              isHovered,
            ));
  }
}
