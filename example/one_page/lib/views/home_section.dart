import '../app/fonts.dart';
import '../app/text_styles.dart';

import 'package:flutter_next/flutter_next.dart';
import '../home.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.8,
      child: NextRow(verticalAlignment: WrapAlignment.center, children: [
        NextCol(
            sizes: 'col-12 col-lg-12',
            child: Column(
              children: [
                Text(
                  'One Page Bootstrap\nWebsite Template',
                  style: h1(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'We are team of talented designers',
                  style: h2(context),
                  textAlign: TextAlign.center,
                ).container(const EdgeInsets.only(top: 10)),
                NextButton(
                  color: context.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  margin: const EdgeInsets.only(top: 30),
                  onPressed: () {
                    Scrollable.ensureVisible(
                        sectionKeys["About"]?.currentContext ?? context,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.linear);
                  },
                  child: (bool isHovered) => const Text(
                    'Get started',
                    style: TextStyle(
                        fontFamily: Fonts.poppins,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ).fadeIn(
                variant: NextFadeInVariant.fadeInTop, initialPosition: 120))
      ]),
    );
  }
}
