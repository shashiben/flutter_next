import 'package:line_icons/line_icons.dart';

import '../app/fonts.dart';
import '../models/team_model.dart';
import 'package:flutter_next/flutter_next.dart';

class TeamItem extends StatelessWidget {
  final TeamModel member;
  const TeamItem({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      builder: (BuildContext context, bool isHovered) => Container(
        width: context.width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(18, 66, 101, 0.08),
            blurRadius: 15,
            spreadRadius: isHovered ? 10 : 5,
            offset: Offset(
              2.0,
              isHovered ? 6.0 : 2.0,
            ),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Column(children: [
          Stack(
            children: [
              Image.asset(
                member.image,
                fit: BoxFit.fitHeight,
                width: context.width,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isHovered ? 1 : 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.8)),
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          (LineIcons.twitter),
                          (LineIcons.facebook),
                          (LineIcons.instagram),
                          (LineIcons.linkedin)
                        ]
                            .map((IconData e) => HoverWidget(
                                  builder: (BuildContext context,
                                          bool isIconHovered) =>
                                      Icon(
                                    e,
                                    size: 20,
                                    color: isIconHovered
                                        ? context.primaryColor
                                        : const Color(0xFF124265),
                                  ),
                                ))
                            .toList()),
                  ),
                ),
              )
            ],
          ).clipRRect(topLeft: 6, topRight: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                      fontFamily: Fonts.raleway,
                      fontSize: 18,
                      color: Color(0xFF124265),
                      fontWeight: FontWeight.w700),
                ).container(const EdgeInsets.only(bottom: 5)),
                Text(
                  member.role,
                  style: const TextStyle(
                      fontFamily: Fonts.openSans,
                      fontSize: 13,
                      color: Color(0xFFAAAAAA)),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
