import '../../flutter_next.dart';

class NextGridItem extends StatelessWidget {
  ///
  ///  If [sizes] is null then it will take from [NextGrid] parent size value
  ///
  final String? sizes;

  ///
  /// Child
  ///
  final Widget child;
  const NextGridItem({Key? key, this.sizes, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
