import 'package:one_page/widgets/video_play_button.dart';
import 'package:one_page/widgets/video_player.dart';
import 'package:flutter_next/flutter_next.dart';

import '../app/colors.dart';
import '../app/fonts.dart';
import '../ordered_list.dart';

class VideoSection extends StatelessWidget {
  const VideoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.isMobile
              ? 20
              : context.width > 992
                  ? 60
                  : 40,
          vertical: 50),
      child: NextRow(children: [
        NextCol(
            sizes: 'col-12 col-md-6 col-sm-12',
            child: Stack(
              children: [
                Image.asset(
                  'assets/about-video.jpg',
                  fit: BoxFit.fitWidth,
                ),
                Positioned.fill(
                  child: const VideoPlayButton().onTap(() {
                    showDialog<void>(
                        context: context,
                        builder: (_) => Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: context.width * 0.95,
                                height: context.height * 0.95,
                                child: Stack(children: [
                                  Positioned(
                                      top: 15,
                                      right: 15,
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ).onTap(() {
                                        Navigator.pop(context);
                                      })),
                                  Positioned.fill(
                                      child: Center(
                                    child: const VideoPlayer()
                                        .container(const EdgeInsets.all(20)),
                                  ))
                                ]),
                              ),
                            ));
                  }).center(),
                )
              ],
            ).fadeIn(variant: NextFadeInVariant.fadeInRight)),
        NextCol(
            sizes: 'col-12 col-md-6 col-sm-12',
            child: Column(
              children: [
                const Text(
                  'Voluptatem dignissimos provident quasi corporis voluptates sit assumenda.',
                  style: TextStyle(
                      fontFamily: Fonts.raleway,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: textPrimaryColor),
                ).container(const EdgeInsets.only(bottom: 8)),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                      fontFamily: Fonts.openSans,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF444444)),
                ).container(const EdgeInsets.only(bottom: 16)),
                OrderedList(
                    children: [
                  'Ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  'Duis aute irure dolor in reprehenderit in voluptate velit.',
                  'Voluptate repellendus pariatur reprehenderit corporis sint.',
                  'Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate trideta storacalaperda mastiro dolore eu fugiat nulla pariatur.'
                ]
                        .map((String e) => Text(
                              e,
                              style: const TextStyle(
                                  fontFamily: Fonts.openSans,
                                  fontSize: 15,
                                  color: Color(0xFF444444)),
                            ).container(const EdgeInsets.only(top: 10)))
                        .toList()),
                const Text(
                        'Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                        style: TextStyle(
                            fontFamily: Fonts.openSans,
                            fontSize: 15,
                            color: Color(0xFF444444)))
                    .container(const EdgeInsets.only(top: 20))
              ],
            ).fadeIn())
      ]),
    );
  }
}
