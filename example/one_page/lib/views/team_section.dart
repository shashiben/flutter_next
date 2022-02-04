import '../app/data.dart';
import '../app/text_styles.dart';

import 'package:flutter_next/flutter_next.dart';
import '../models/team_model.dart';
import '../widgets/team_item.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FBFE),
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Team',
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
          Container(
            margin: EdgeInsets.only(bottom: context.height * 0.1),
            padding: EdgeInsets.symmetric(
                horizontal: context.isMobile ? 20 : context.width * 0.05),
            child: NextRow(
                children: teamList
                    .map((TeamModel e) => NextCol(
                          sizes: 'col-12 col-lg-3 col-md-6 col-sm-12',
                          child: Center(
                            child: TeamItem(
                              member: e,
                            ),
                          ),
                        ))
                    .toList()),
          ).fadeIn(
            variant: NextFadeInVariant.fadeInTop,
          ),
        ],
      ),
    );
  }
}
