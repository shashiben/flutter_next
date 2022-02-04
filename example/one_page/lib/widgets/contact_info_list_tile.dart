import 'package:flutter_next/flutter_next.dart';

import '../app/fonts.dart';

class ContactListTile extends StatelessWidget {
  final String title, subtitle;
  final IconData leadingIcon;
  const ContactListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.leadingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      builder: (BuildContext context, bool isHovered) => Row(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: isHovered
                      ? const Color(0xFF2487ce)
                      : context.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.all(8),
              child: Icon(
                leadingIcon,
                size: 20,
                color: isHovered ? Colors.white : context.primaryColor,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontFamily: Fonts.raleway,
                    fontSize: 22,
                    color: Color(0xFF124265),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    fontFamily: Fonts.openSans,
                    color: Color(0xFF217bbc),
                    fontWeight: FontWeight.w400),
              )
            ],
          ).container(const EdgeInsets.only(left: 15)),
        ],
      ),
    ).container(const EdgeInsets.only(bottom: 40));
  }
}
