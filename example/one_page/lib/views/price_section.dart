import '../app/data.dart';
import '../app/text_styles.dart';

import 'package:flutter_next/flutter_next.dart';
import '../models/pricing_model.dart';
import '../widgets/pricing_item.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFDFDFD),
      ),
      child: Column(children: [
        Column(
          children: [
            Text(
              'PRICING',
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
            duration: const Duration(milliseconds: 600)),
        LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth * 0.8,
            child:
                NextRow(horizontalSpacing: 10, verticalSpacing: 30, children: [
              ...priceList
                  .map((PricingModel e) => NextCol(
                        sizes: 'col-6 col-md-6 col-lg-4 col-xs-12',
                        child: PricingItem(
                          index: priceList.indexOf(e),
                          pricingModel: e,
                          isActive: priceList.indexOf(e) == 1,
                        ).zoom(
                          duration: const Duration(milliseconds: 600),
                        ),
                      ))
                  .toList()
            ]),
          );
        }),
      ]),
    );
  }
}
