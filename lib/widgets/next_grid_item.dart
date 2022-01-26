import '../flutter_next.dart';

class NextGridItem extends StatelessWidget {
  final String? sizes;
  final Widget child;
  const NextGridItem({Key? key, this.sizes, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
