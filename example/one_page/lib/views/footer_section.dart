import 'package:flutter/gestures.dart';
import 'package:line_icons/line_icons.dart';

import '../app/colors.dart';
import '../app/fonts.dart';

import 'package:flutter_next/flutter_next.dart';
import '../widgets/footer_item.dart';
import '../widgets/news_letter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.isMobile ? 20 : context.width * 0.05,
              vertical: 40),
          color: Colors.white,
          width: context.width,
          child: NextRow(verticalSpacing: 30, children: [
            NextCol(
                sizes: 'col-12 cik-md-6 col-lg-3',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OnePage',
                      style: TextStyle(
                          fontFamily: Fonts.raleway,
                          fontSize: 26,
                          color: Color(0xFF444444)),
                    ).container(const EdgeInsets.only(bottom: 10)),
                    const Text(
                      'A108 Adam Street\nNew York, NY 535022\nUnited States',
                      style: TextStyle(
                          fontFamily: Fonts.raleway,
                          height: 1.5,
                          fontSize: 14,
                          color: Color(0xFF777777)),
                    ).container(const EdgeInsets.only(bottom: 15)),
                    const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Phone:',
                          style: TextStyle(
                              fontFamily: Fonts.raleway,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF444444))),
                      TextSpan(
                          text: '+91-7997217156',
                          style: TextStyle(
                              fontFamily: Fonts.raleway,
                              fontSize: 14,
                              color: Color(0xFF777777)))
                    ])).container(const EdgeInsets.only(bottom: 8)),
                    const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Email:',
                          style: TextStyle(
                              fontFamily: Fonts.raleway,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF444444))),
                      TextSpan(
                          text: 'kumarshashi5294@gmail.com',
                          style: TextStyle(
                              fontFamily: Fonts.raleway,
                              fontSize: 14,
                              color: Color(0xFF777777)))
                    ]))
                  ],
                )),
            NextCol(
                sizes: 'col-12 col-md-6 col-lg-2',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Useful Links',
                      style: TextStyle(
                          fontFamily: Fonts.raleway,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textPrimaryColor),
                    ).container(const EdgeInsets.only(bottom: 12)),
                    const FooterItem(title: 'Home'),
                    const FooterItem(title: 'About us'),
                    const FooterItem(title: 'Services'),
                    const FooterItem(title: 'Terms of service'),
                    const FooterItem(title: 'Privacy policy'),
                  ],
                )),
            NextCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Our Services',
                      style: TextStyle(
                          fontFamily: Fonts.raleway,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textPrimaryColor),
                    ).container(const EdgeInsets.only(bottom: 12)),
                    const FooterItem(title: 'Web Design'),
                    const FooterItem(title: 'Web Development'),
                    const FooterItem(title: 'Product Management'),
                    const FooterItem(title: 'Marketing'),
                    const FooterItem(title: 'Graphic Design'),
                  ],
                )),
            const NextCol(
                sizes: 'col-12 col-md-6 col-lg-4', child: NewsLetterWidget())
          ]),
        ),
        Container(
          color: const Color(0xFFF8FBFE),
          padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: context.isMobile ? 20 : context.width * 0.05),
          width: context.width,
          child: Container(
            color: const Color(0xFFF8FBFE),
            width: context.width,
            child: NextRow(verticalSpacing: 15, children: [
              NextCol(
                  sizes: 'col-12 col-md-6',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text.rich(TextSpan(
                          style: TextStyle(
                            fontFamily: Fonts.openSans,
                          ),
                          children: [
                            TextSpan(text: '© Copyright '),
                            TextSpan(
                                text: 'OnePage. ',
                                style: TextStyle(
                                    fontFamily: Fonts.openSans,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(text: 'All Rights Reserved')
                          ])).container(const EdgeInsets.only(bottom: 10)),
                      Text.rich(TextSpan(
                          style: const TextStyle(
                            fontFamily: Fonts.openSans,
                          ),
                          children: [
                            const TextSpan(text: 'Coded by '),
                            TextSpan(
                                text: 'Shashi Kumar. ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: TextStyle(
                                    fontFamily: Fonts.openSans,
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ])),
                    ],
                  )),
              NextCol(
                  sizes: 'col-12 col-lg-6 col-md-6',
                  child: Row(
                    mainAxisAlignment: context.isMobile
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.end,
                    children: [
                      NextButton(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(10),
                          child: (bool isHovered) => const Icon(
                                Icons.facebook_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                          onPressed: () {}),
                      NextButton(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(10),
                          child: (bool isHovered) => const Icon(
                                LineIcons.instagram,
                                color: Colors.white,
                                size: 20,
                              ),
                          onPressed: () {}),
                      NextButton(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(10),
                          child: (bool isHovered) => const Icon(
                                LineIcons.linkedinIn,
                                color: Colors.white,
                                size: 20,
                              ),
                          onPressed: () {}),
                      NextButton(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(10),
                          child: (bool isHovered) => const Icon(
                                LineIcons.github,
                                color: Colors.white,
                                size: 20,
                              ),
                          onPressed: () {}),
                      NextButton(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(10),
                          child: (bool isHovered) => const Icon(
                                LineIcons.facebook,
                                color: Colors.white,
                                size: 20,
                              ),
                          onPressed: () {}),
                    ],
                  ))
            ]),
          ),
        ),
      ],
    );
  }
}
