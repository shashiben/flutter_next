import 'package:line_icons/line_icons.dart';

import '../app/colors.dart';
import '../app/data.dart';
import '../app/fonts.dart';
import '../app/text_styles.dart';
import 'package:flutter_next/flutter_next.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 60,
          horizontal: context.isMobile ? 20 : context.width * 0.05),
      color: const Color.fromRGBO(248, 251, 254, 1),
      width: double.infinity,
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'FREQUENTLY ASKED QUESTIONS',
                textAlign: TextAlign.center,
                style: SectionTitle.h2(context),
              ).container(const EdgeInsets.only(bottom: 20)),
              SizedBox(
                width:
                    context.isMobile ? context.width - 40 : context.width * 0.8,
                child: Text(
                  'Magnam dolores commodi suscipit. Necessitatibus eius consequatur ex aliquid fuga eum quidem. Sit sint consectetur velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem hic quas.',
                  style: SectionTitle.p(context),
                  textAlign: TextAlign.center,
                ).container(const EdgeInsets.only(bottom: 30)),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ).fadeIn(
              variant: NextFadeInVariant.fadeInTop,
              initialPosition: 80,
              duration: const Duration(milliseconds: 300)),
          Column(
            children: [
              ...faqList.entries
                  .map((MapEntry<String, String> e) => HoverWidget(
                        builder: (BuildContext context, bool isHovered) =>
                            NextAccordion(
                          horizontalTitleGap: context.isMobile ? 5 : 10,
                          collapsedBackgroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          leading: const Icon(
                            LineIcons.questionCircle,
                            size: 24,
                            color: Color(0xFF87c1ea),
                          ),
                          borderColor: Colors.white,
                          childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ).copyWith(bottom: 15),
                          trailing: (bool isExpanded) => Transform.rotate(
                            angle: isExpanded ? -pi : 0,
                            child: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: (isExpanded || isHovered)
                                  ? const Color(0xFF2487ce)
                                  : textPrimaryColor,
                            ),
                          ),
                          title: Text(
                            e.key,
                            style: TextStyle(
                                fontFamily: Fonts.poppins,
                                color: isHovered
                                    ? const Color(0xFF2487ce)
                                    : textPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                          initiallyExpanded:
                              faqList.keys.toList().indexOf(e.key) == 0,
                          children: [
                            Text(
                              e.value,
                              textAlign: TextAlign.start,
                            ).container(const EdgeInsets.only(top: 10))
                          ],
                        ),
                      ).container(const EdgeInsets.only(top: 20)))
                  .toList()
            ],
          ).fadeIn(
              variant: NextFadeInVariant.fadeInTop,
              duration: const Duration(milliseconds: 400)),
        ],
      ),
    );
  }
}
