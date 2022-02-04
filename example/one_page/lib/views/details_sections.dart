import 'package:one_page/widgets/text_counter.dart';
import '../app/data.dart';
import '../app/fonts.dart';
import 'package:flutter_next/flutter_next.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FBFE),
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: NextRow(
          children: details.entries
              .map((MapEntry<String, int> e) => NextCol(
                  sizes: 'col-6 col-md-6 col-lg-3 col-sm-6 col-xs-6',
                  child: Column(
                    children: [
                      AnimatedCounter(
                          begin: 0,
                          duration: const Duration(seconds: 5),
                          end: e.value.toDouble(),
                          style: const TextStyle(
                              fontFamily: Fonts.openSans,
                              fontWeight: FontWeight.w700,
                              fontSize: 48,
                              color: Color(0xFF124265))),
                      Text(
                        e.key,
                        style: const TextStyle(
                            fontFamily: Fonts.raleway,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ).container(const EdgeInsets.only(top: 8))
                    ],
                  )))
              .toList()),
    );
  }
}
