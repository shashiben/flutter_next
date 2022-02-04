import 'package:flutter_next/flutter_next.dart';
import 'colors.dart';
import 'fonts.dart';

TextStyle h1(BuildContext context) {
  return TextStyle(
      fontFamily: Fonts.poppins,
      fontSize: context.width >= 992 ? 56 : 28,
      color: textPrimaryColor,
      fontWeight: FontWeight.w700);
}

TextStyle h2(BuildContext context) {
  return TextStyle(
      fontFamily: Fonts.raleway,
      fontSize: context.width >= 992 ? 22 : 18,
      color: textSecondaryColor,
      fontWeight: FontWeight.w400);
}

TextStyle a(BuildContext context) {
  return TextStyle(
      fontFamily: Fonts.raleway,
      fontSize: context.width >= 992 ? 18 : 16,
      color: textPrimaryColor,
      fontWeight: FontWeight.bold);
}

class SectionTitle {
  static TextStyle h2(BuildContext context) {
    return const TextStyle(
        fontFamily: Fonts.raleway,
        fontSize: 32,
        color: textPrimaryColor,
        fontWeight: FontWeight.bold);
  }

  static TextStyle p(BuildContext context) {
    return const TextStyle(
      fontFamily: Fonts.openSans,
      fontSize: 14,
      color: Color(0xFF919191),
    );
  }
}

class AboutTextStyles {
  static TextStyle li(BuildContext context) {
    return const TextStyle(
      fontFamily: Fonts.openSans,
      fontSize: 14,
      color: Color(0xFF444444),
    );
  }
}
