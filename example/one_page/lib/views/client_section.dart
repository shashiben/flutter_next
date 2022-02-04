import 'package:flutter_next/flutter_next.dart';
import '../widgets/company_logo_item.dart';

class ClientSection extends StatelessWidget {
  const ClientSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FBFE),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: context.width,
      child: NextRow(
        children: List.generate(
            6,
            (int index) => NextCol(
                sizes: 'col-lg-2 col-md-4 col-6 col-sm-6 col-xs-6',
                child: CompanyLogoItem(
                  image: 'assets/clients/client-${index + 1}.png',
                ).container(const EdgeInsets.symmetric(horizontal: 15)).zoom(
                      duration: const Duration(milliseconds: 300),
                    ))),
      ),
    );
  }
}
