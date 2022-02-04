import 'package:flutter_next/flutter_next.dart';

import '../app/fonts.dart';

class FooterItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const FooterItem({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      builder: (BuildContext context, bool isHovered) => Row(
        children: [
          Icon(
            Icons.arrow_forward_ios,
            color: context.primaryColor,
            size: 14,
          ).container(const EdgeInsets.only(right: 10)),
          InkWell(
            onTap: () {},
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: Fonts.openSans,
                  fontSize: 14,
                  color: isHovered
                      ? context.primaryColor
                      : const Color(0xFF444444)),
            ),
          ),
        ],
      ).container(const EdgeInsets.symmetric(vertical: 8)),
    );
  }
}
