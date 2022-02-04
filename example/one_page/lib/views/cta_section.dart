import '../app/fonts.dart';
import 'package:flutter_next/flutter_next.dart';

class CTASection extends StatelessWidget {
  const CTASection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(color: context.primaryColor),
      child: Column(
        children: [
          const Text(
            'Call To Action',
            style: TextStyle(
                fontFamily: Fonts.raleway,
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: context.width * 0.8,
            child: const Text(
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: TextStyle(
                  fontFamily: Fonts.openSans,
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ).container(const EdgeInsets.only(top: 20, bottom: 20)),
          ),
          NextButton(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              color: Colors.white,
              outlineColor: context.primaryColor,
              variant: NextButtonVariant.outlined,
              child: (bool isHovered) => Text(
                    'Call To Action',
                    style: TextStyle(
                        fontFamily: Fonts.openSans,
                        fontWeight: FontWeight.bold,
                        color: isHovered ? context.primaryColor : Colors.white),
                  ),
              onPressed: () {})
        ],
      ).zoom(
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}
