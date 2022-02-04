import 'package:flutter_next/flutter_next.dart';

import 'views/about_section.dart';
import 'views/client_section.dart';
import 'views/contact_section.dart';
import 'views/cta_section.dart';
import 'views/faq_section.dart';
import 'views/footer_section.dart';
import 'views/header_section.dart';
import 'views/home_section.dart';
import 'views/icon_section.dart';
import 'views/portfolio_section.dart';
import 'views/price_section.dart';
import 'views/services_section.dart';
import 'views/team_section.dart';
import 'views/testimonial_section.dart';

final Map<String, GlobalKey<State<StatefulWidget>>> sectionKeys = {
  'Home': GlobalKey(debugLabel: 'Home'),
  'About': GlobalKey(debugLabel: 'About'),
  'Services': GlobalKey(debugLabel: 'Services'),
  'Portfolio': GlobalKey(debugLabel: 'Portfolio'),
  'Team': GlobalKey(debugLabel: 'Team'),
  'Pricing': GlobalKey(debugLabel: 'Pricing'),
  'Contact': GlobalKey(debugLabel: 'Contact'),
};

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  double currentHeight = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        currentHeight = scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: currentHeight > 250
              ? FloatingActionButton(
                  elevation: 0,
                  mini: true,
                  backgroundColor: context.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onPressed: () {
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.linear);
                  },
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        body: Column(
          children: [
            HeaderSection(
              titles: const [
                'Home',
                'About',
                'Services',
                'Portfolio',
                'Team',
                'Pricing',
                'Contact'
              ],
              keyList: sectionKeys,
            ),
            Expanded(
              child: NextContainer(
                  scrollController: scrollController,
                  fluid: true,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white),
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Color.fromRGBO(255, 255, 255, 0.8),
                                  BlendMode.lighten),
                              image: AssetImage('assets/hero-bg.jpg'),
                              fit: BoxFit.fill)),
                      child: Column(
                        children: [
                          HomeSection(
                            key: sectionKeys['Home'],
                          ),
                          const IconSection(),
                        ],
                      ),
                    ),
                    AboutSection(
                      key: sectionKeys['About'],
                    ),
                    const ClientSection(),
                    const TestimonialSection(),
                    ServicesSection(
                      key: sectionKeys['Services'],
                    ),
                    const CTASection(),
                    PortfolioSection(
                      key: sectionKeys['Portfolio'],
                    ),
                    TeamSection(
                      key: sectionKeys['Team'],
                    ),
                    PriceSection(
                      key: sectionKeys['Pricing'],
                    ),
                    const FAQSection(),
                    ContactSection(
                      key: sectionKeys['Contact'],
                    ),
                    const FooterSection()
                  ]),
            ),
          ],
        )).safeArea(top: context.isMobile);
  }
}
