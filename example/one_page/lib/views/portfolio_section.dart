import '../app/colors.dart';
import '../app/data.dart';
import '../app/fonts.dart';
import '../app/text_styles.dart';
import '../models/portfolio_model.dart';
import '../widgets/portfolio_item.dart';
import 'package:flutter_next/flutter_next.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({Key? key}) : super(key: key);

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  List<String> tabs = ['All', 'App', 'Card', 'Web'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PORTFOLIO',
              style: SectionTitle.h2(context),
              textAlign: TextAlign.center,
            ),
            Text(
              'Magnam dolores commodi suscipit. Necessitatibus eius consequatur ex aliquid fuga eum quidem.',
              style: SectionTitle.p(context),
              textAlign: TextAlign.center,
            ).container(const EdgeInsets.only(top: 10, bottom: 20)),
          ],
        ).fadeIn(
          variant: NextFadeInVariant.fadeInTop,
          initialPosition: 80,
        ),
        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    tabs.length,
                    (int index) => HoverWidget(
                          builder: (BuildContext context, bool isTabHovered) =>
                              Text(
                            tabs[index].toUpperCase(),
                            style: TextStyle(
                                fontFamily: Fonts.openSans,
                                color: (index == selectedIndex || isTabHovered)
                                    ? context.primaryColor
                                    : textPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                                  .container(const EdgeInsets.fromLTRB(
                            10,
                            15,
                            8,
                            15,
                          ))
                                  .onTap(() {
                            setState(() {
                              selectedIndex = index;
                            });
                          }),
                        )))
            .fadeIn(initialPosition: 80, variant: NextFadeInVariant.fadeInTop),
        NextGridView(
                sizes: 'col-12 col-lg-4 col-md-6',
                // horizontalSpacing: 20,
                // verticalSpacing: 20,
                childrens: portfolioItems
                    .where((e) => (e.type == tabs.elementAt(selectedIndex) ||
                        selectedIndex == 0))
                    .map((PortfolioModel e) => NextGridItem(
                          child: PortfolioItem(
                            portfolioItem: e,
                            shouldDisplay: true,
                          ),
                        ))
                    .toList())
            .fadeIn(variant: NextFadeInVariant.fadeInTop)
      ]).container(const EdgeInsets.symmetric(horizontal: 20, vertical: 60)),
    );
  }
}
