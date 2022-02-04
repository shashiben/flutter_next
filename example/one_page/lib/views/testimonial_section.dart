import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import '../app/data.dart';
import '../app/text_styles.dart';
import 'package:flutter_next/flutter_next.dart';
import '../models/testimonial_model.dart';
import '../widgets/testimonial_item.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({Key? key}) : super(key: key);

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  int currentIndex = 0;
  late CarouselController pageController;
  @override
  void initState() {
    super.initState();
    pageController = CarouselController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TESTIMONIALS',
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
          Column(
            children: [
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: CarouselSlider(
                  carouselController: pageController,
                  options: CarouselOptions(
                      height: 420,
                      viewportFraction: context.isMobile
                          ? 1
                          : context.isMd
                              ? 1 / 2
                              : 1 / 3,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      }),
                  items: reviewsList
                      .map((TestimonialModel e) => TestimonialItem(review: e)
                          .sizedBox(width: 395, height: 420))
                      .toList(),
                ),
              ).container(EdgeInsets.symmetric(
                  horizontal: context.isMobile ? 20 : context.width * 0.05)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      reviewsList.length,
                      (int index) => AnimatedContainer(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index == currentIndex
                                          ? context.primaryColor
                                          : context.primaryColor
                                              .withOpacity(0.4)),
                                  duration: const Duration(milliseconds: 300))
                              .onTap(() {
                            pageController.animateToPage(index);
                          })))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ).fadeIn(
            variant: NextFadeInVariant.fadeInTop,
          ),
        ],
      ).container(const EdgeInsets.symmetric(vertical: 60)),
    );
  }
}
