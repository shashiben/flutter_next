import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';

import '../models/feature_model.dart';
import '../models/portfolio_model.dart';
import '../models/pricing_model.dart';
import '../models/service_model.dart';
import '../models/team_model.dart';
import '../models/testimonial_model.dart';

List<FeatureModel> featuresList = [
  FeatureModel(
      icon: LineIcons.layerGroup,
      title: 'Lorem Ipsum',
      description:
          'Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi'),
  FeatureModel(
      icon: LineIcons.palette,
      title: 'Sed ut perspiciatis',
      description:
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore'),
  FeatureModel(
      icon: LineIcons.megaport,
      title: 'Magni Dolores',
      description:
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia'),
  FeatureModel(
      icon: LineIcons.fingerprint,
      title: 'Nemo Enim',
      description:
          'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis')
];
List<TeamModel> teamList = [
  TeamModel(
      name: 'Walter White',
      image: 'assets/team/team-1.jpg',
      role: 'Chief Executive Officer'),
  TeamModel(
      name: 'Sarah Jhonson',
      image: 'assets/team/team-2.jpg',
      role: 'Product Manager'),
  TeamModel(
      name: 'William Anderson', image: 'assets/team/team-3.jpg', role: 'CTO'),
  TeamModel(
      name: 'Amanda Jepson',
      image: 'assets/team/team-4.jpg',
      role: 'Accountant')
];
Map<String, int> details = {
  'Happy Clients': 65,
  'Projects': 85,
  'Years of experience': 30,
  'Awards': 20
};
Map<String, String> faqList = {
  'Non consectetur a erat nam at lectus urna duis?':
      'Feugiat pretium nibh ipsum consequat. Tempus iaculis urna id volutpat lacus laoreet non curabitur gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus non.',
  'Feugiat scelerisque varius morbi enim nunc?':
      'Dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Id interdum velit laoreet id donec ultrices. Fringilla phasellus faucibus scelerisque eleifend donec pretium. Est pellentesque elit ullamcorper dignissim. Mauris ultrices eros in cursus turpis massa tincidunt dui.',
  'Dolor sit amet consectetur adipiscing elit?':
      'Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis orci. Faucibus pulvinar elementum integer enim. Sem nulla pharetra diam sit amet nisl suscipit. Rutrum tellus pellentesque eu tincidunt. Lectus urna duis convallis convallis tellus. Urna molestie at elementum eu facilisis sed odio morbi quis',
  'Tempus quam pellentesque nec nam aliquam sem et tortor consequat?':
      'Molestie a iaculis at erat pellentesque adipiscing commodo. Dignissim suspendisse in est ante in. Nunc vel risus commodo viverra maecenas accumsan. Sit amet nisl suscipit adipiscing bibendum est. Purus gravida quis blandit turpis cursus in.',
  'Tortor vitae purus faucibus ornare. Varius vel pharetra vel turpis nunc eget lorem dolor?':
      'Laoreet sit amet cursus sit amet dictum sit amet justo. Mauris vitae ultricies leo integer malesuada nunc vel. Tincidunt eget nullam non nisi est sit amet. Turpis nunc eget lorem dolor sed. Ut venenatis tellus in metus vulputate eu scelerisque.'
};
List<PricingModel> priceList = [
  PricingModel(name: 'FREE', price: 0, included: [
    'Aida dere',
    'Nec feugiat nisl',
    'Nulla at volutpat dola',
  ], notIncluded: [
    'Pharetra massa',
    'Massa ultricies mi'
  ]),
  PricingModel(name: 'BUSINESS', price: 19, included: [
    'Aida dere',
    'Nec feugiat nisl',
    'Nulla at volutpat dola',
    'Pharetra massa',
  ], notIncluded: [
    'Massa ultricies mi'
  ]),
  PricingModel(name: 'DEVELOPER', price: 029, included: [
    'Aida dere',
    'Nec feugiat nisl',
    'Nulla at volutpat dola',
    'Pharetra massa',
    'Massa ultricies mi'
  ], notIncluded: [])
];
List<ServiceModel> servicesList = [
  ServiceModel(
      title: 'Lorem Ipsum',
      background: '''
       <svg width="100" height="100" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5" d="M300,521.0016835830174C376.1290562159157,517.8887921683347,466.0731472004068,529.7835943286574,510.70327084640275,468.03025145048787C554.3714126377745,407.6079735673963,508.03601936045806,328.9844924480964,491.2728898941984,256.3432110539036C474.5976632858925,184.082847569629,479.9380746630129,96.60480741107993,416.23090153303,58.64404602377083C348.86323505073057,18.502131276798302,261.93793281208167,40.57373210992963,193.5410806939664,78.93577620505333C130.42746243093433,114.334589627462,98.30271207620316,179.96522072025542,76.75703585869454,249.04625023123273C51.97151888228291,328.5150500222984,13.704378332031375,421.85034740162234,66.52175969318436,486.19268352777647C119.04800174914682,550.1803526380478,217.28368757567262,524.383925680826,300,521.0016835830174"></path>
                </svg>''',
      description:
          'Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi',
      color: const Color(0xFF47aeff),
      icon: LineIcons.footballBall),
  ServiceModel(
      background: '''
      <svg width="100" height="100" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5" d="M300,582.0697525312426C382.5290701553225,586.8405444964366,449.9789794690241,525.3245884688669,502.5850820975895,461.55621195738473C556.606425686781,396.0723002908107,615.8543463187945,314.28637112970534,586.6730223649479,234.56875336149918C558.9533121215079,158.8439757836574,454.9685369536778,164.00468322053177,381.49747125262974,130.76875717737553C312.15926192815925,99.40240125094834,248.97055460311594,18.661163978235184,179.8680185752513,50.54337015887873C110.5421016452524,82.52863877960104,119.82277516462835,180.83849132639028,109.12597500060166,256.43424936330496C100.08760227029461,320.3096726198365,92.17705696193138,384.0621239912766,124.79988738764834,439.7174275375508C164.83382741302287,508.01625554203684,220.96474134820875,577.5009287672846,300,582.0697525312426"></path>
                </svg>''',
      title: 'Lorem Ipsum',
      description:
          'Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi',
      color: const Color(0xFFffa76e),
      icon: LineIcons.file),
  ServiceModel(
      background: '''
       <svg width="100" height="100" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5" d="M300,541.5067337569781C382.14930387511276,545.0595476570109,479.8736841581634,548.3450877840088,526.4010558755058,480.5488172755941C571.5218469581645,414.80211281144784,517.5187510058486,332.0715597781072,496.52539010469104,255.14436215662573C477.37192572678356,184.95920475031193,473.57363656557914,105.61284051026155,413.0603344069578,65.22779650032875C343.27470386102294,18.654635553484475,251.2091493199835,5.337323636656869,175.0934190732945,40.62881213300186C97.87086631185822,76.43348514350839,51.98124368387456,156.15599469081315,36.44837278890362,239.84606092416172C21.716077023791087,319.22268207091537,43.775223500013084,401.1760424656574,96.891909868211,461.97329694683043C147.22146801428983,519.5804099606455,223.5754009179313,538.201503339737,300,541.5067337569781"></path>
                </svg>''',
      title: 'Lorem Ipsum',
      description:
          'Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi',
      color: const Color(0xFFe80368),
      icon: LineIcons.meteor),
  ServiceModel(
      background: '''
       <svg width="100" height="100" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5" d="M300,503.46388370962813C374.79870501325706,506.71871716319447,464.8034551963731,527.1746412648533,510.4981551193396,467.86667711651364C555.9287308511215,408.9015244558933,512.6030010748507,327.5744911775523,490.211057578863,256.5855673507754C471.097692560561,195.9906835881958,447.69079081568157,138.11976852964426,395.19560036434837,102.3242989838813C329.3053358748298,57.3949838291264,248.02791733380457,8.279543830951368,175.87071277845988,42.242879143198664C103.41431057327972,76.34704239035025,93.79494320519305,170.9812938413882,81.28167332365135,250.07896920659033C70.17666984294237,320.27484674793965,64.84698225790005,396.69656628748305,111.28512138212992,450.4950937839243C156.20124167950087,502.5303643271138,231.32542653798444,500.4755392045468,300,503.46388370962813"></path>
                </svg>''',
      title: 'Lorem Ipsum',
      description:
          'Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi',
      color: const Color(0xFFffbb2c),
      icon: LineIcons.layerGroup),
  ServiceModel(
      background: '''
         <svg width="100" height="100" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5" d="M300,532.3542879108572C369.38199826031484,532.3153073249985,429.10787420159085,491.63046689027357,474.5244479745417,439.17860296908856C522.8885846962883,383.3225815378663,569.1668002868075,314.3205725914397,550.7432151929288,242.7694973846089C532.6665558377875,172.5657663291529,456.2379748765914,142.6223662098291,390.3689995646985,112.34683881706744C326.66090330228417,83.06452184765237,258.84405631176094,53.51806209861945,193.32584062364296,78.48882559362697C121.61183558270385,105.82097193414197,62.805066853699245,167.19869350419734,48.57481801355237,242.6138429142374C34.843463184063346,315.3850353017275,76.69343916112496,383.4422959591041,125.22947124332185,439.3748458443577C170.7312796277747,491.8107796887764,230.57421082200815,532.3932930995766,300,532.3542879108572"></path>
                </svg>''',
      title: 'Lorem Ipsum',
      description:
          'Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi',
      color: const Color(0xFFff5828),
      icon: LineIcons.television),
  ServiceModel(
      background: '''
        <svg width="100" height="100" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5" d="M300,566.797414625762C385.7384707136149,576.1784315230908,478.7894351017131,552.8928747891023,531.9192734346935,484.94944893311C584.6109503024035,417.5663521118492,582.489472248146,322.67544863468447,553.9536738515405,242.03673114598146C529.1557734026468,171.96086150256528,465.24506316201064,127.66468636344209,395.9583748389544,100.7403814666027C334.2173773831606,76.7482773500951,269.4350130405921,84.62216499799875,207.1952322260088,107.2889140133804C132.92018162631612,134.33871894543012,41.79353780512637,160.00259165414826,22.644507872594943,236.69541883565114C3.319112789854554,314.0945973066697,72.72355303640163,379.243833228382,124.04198916343866,440.3218312028393C172.9286146004772,498.5055451809895,224.45579914871206,558.5317968840102,300,566.797414625762"></path>
                </svg>''',
      title: 'Lorem Ipsum',
      description:
          'Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi',
      color: const Color(0xFF11dbcf),
      icon: LineIcons.tableTennis),
];
List<TestimonialModel> reviewsList = [
  const TestimonialModel(
      name: 'Saul Goodman',
      image: 'assets/testimonials/testimonials-1.jpg',
      role: 'Ceo & Founder',
      review:
          'Proin iaculis purus consequat sem cure digni ssim donec porttitora entum suscipit rhoncus. Accusantium quam, ultricies eget id, aliquam eget nibh et. Maecen aliquam, risus at semper.'),
  const TestimonialModel(
      name: 'Sara Wilsson',
      image: 'assets/testimonials/testimonials-2.jpg',
      role: 'Designer',
      review:
          'Export tempor illum tamen malis malis eram quae irure esse labore quem cillum quid cillum eram malis quorum velit fore eram velit sunt aliqua noster fugiat irure amet legam anim culpa.'),
  const TestimonialModel(
      name: 'Jena Karlis',
      image: 'assets/testimonials/testimonials-3.jpg',
      role: 'Store Owner',
      review:
          'Enim nisi quem export duis labore cillum quae magna enim sint quorum nulla quem veniam duis minim tempor labore quem eram duis noster aute amet eram fore quis sint minim.'),
  const TestimonialModel(
      name: 'Matt Brandon',
      image: 'assets/testimonials/testimonials-4.jpg',
      role: 'Freelancer',
      review:
          'Fugiat enim eram quae cillum dolore dolor amet nulla culpa multos export minim fugiat minim velit minim dolor enim duis veniam ipsum anim magna sunt elit fore quem dolore labore illum veniam.'),
  const TestimonialModel(
      name: 'John Larson',
      image: 'assets/testimonials/testimonials-5.jpg',
      role: 'Entrepreneur',
      review:
          'Quis quorum aliqua sint quem legam fore sunt eram irure aliqua veniam tempor noster veniam enim culpa labore duis sunt culpa nulla illum cillum fugiat legam esse veniam culpa fore nisi cillum quid.'),
];
List<PortfolioModel> portfolioItems = [
  PortfolioModel(
      name: 'App 1', type: 'App', image: 'assets/portfolio/portfolio-1.jpg'),
  PortfolioModel(
      name: 'Web 3', type: 'Web', image: 'assets/portfolio/portfolio-2.jpg'),
  PortfolioModel(
      name: 'App 2', type: 'App', image: 'assets/portfolio/portfolio-3.jpg'),
  PortfolioModel(
      name: 'Card 2', type: 'Card', image: 'assets/portfolio/portfolio-4.jpg'),
  PortfolioModel(
      name: 'Web 2', type: 'Web', image: 'assets/portfolio/portfolio-5.jpg'),
  PortfolioModel(
      name: 'App 3', type: 'App', image: 'assets/portfolio/portfolio-6.jpg'),
  PortfolioModel(
      name: 'Card1', type: 'Card', image: 'assets/portfolio/portfolio-7.jpg'),
  PortfolioModel(
      name: 'Card3', type: 'Card', image: 'assets/portfolio/portfolio-8.jpg'),
  PortfolioModel(
      name: 'Web3', type: 'Web', image: 'assets/portfolio/portfolio-9.jpg'),
];
