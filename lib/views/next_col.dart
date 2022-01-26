import '../flutter_next.dart';

class NextCol extends StatelessWidget {
  final String sizes;
  final String offset;
  final List<String> invisibleFor;
  final Widget child;
  const NextCol(
      {Key? key,
      this.sizes = "col-12",
      required this.child,
      this.offset = "",
      this.invisibleFor = const <String>[]})
      : super(key: key);
  double getWidthOfChild(context) {
    return BootstrapUtils.getMaxWidth(sizes, context: context);
  }

  double getOffsetWidth(context) {
    return BootstrapUtils.getMaxWidth(offset, context: context, isOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
