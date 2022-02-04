import 'package:line_icons/line_icons.dart';

import '../app/fonts.dart';
import '../app/text_styles.dart';

import 'package:flutter_next/flutter_next.dart';
import '../widgets/contact_info_list_tile.dart';
import '../widgets/text_field.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                'CONTACT',
                style: SectionTitle.h2(context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Magnam dolores commodi suscipit. Necessitatibus eius consequatur ex aliquid fuga eum quidem. Sit sint consectetur velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem hic quas.',
                style: SectionTitle.p(context),
                textAlign: TextAlign.center,
              ).container(const EdgeInsets.only(top: 10, bottom: 20)),
            ],
          ),
          NextRow(children: [
            NextCol(
                sizes: 'col-12 col-lg-4 col-md-12',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ContactListTile(
                        title: 'Location:',
                        subtitle: 'Kurnool,Andhra Pradesh,518001',
                        leadingIcon: LineIcons.locationArrow),
                    ContactListTile(
                        title: 'Email:',
                        subtitle: 'kumarshashi5294@gmail.com',
                        leadingIcon: Icons.email_outlined),
                    ContactListTile(
                        title: 'Call:',
                        subtitle: '+91-797217156',
                        leadingIcon: Icons.mobile_friendly_rounded)
                  ],
                )),
            NextCol(
                sizes: 'col-12 col-lg-8 col-md-12',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                              controller: nameController, hint: 'Your name'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: CommonTextField(
                              controller: nameController, hint: 'Your Email'),
                        )
                      ],
                    ),
                    CommonTextField(
                        controller: nameController, hint: 'Subject'),
                    CommonTextField(
                        controller: nameController,
                        hint: 'Message',
                        maxLines: 4),
                    NextButton(
                      color: context.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 14),
                      margin: const EdgeInsets.only(top: 30),
                      onPressed: () {},
                      child: (bool isHovered) => const Text(
                        'Send Message',
                        style: TextStyle(
                            fontFamily: Fonts.poppins,
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ))
          ])
        ],
      ).container(EdgeInsets.symmetric(
          vertical: 60, horizontal: context.isMobile ? 20 : 60)),
    );
  }
}
