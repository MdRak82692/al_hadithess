import 'package:get/get.dart';
import '../pages/home/home_page.dart';
import '../pages/chapters/chapters_page.dart';
import '../pages/hadith_details/hadith_details_page.dart';
import '../controllers/home_controller.dart';
import '../controllers/chapters_controller.dart';
import '../controllers/hadith_details_controller.dart';

class AppRoutes {
  static const String home = '/';
  static const String chapters = '/chapters';
  static const String hadithDetails = '/hadith-details';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
    ),
    GetPage(
      name: chapters,
      page: () => ChaptersPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChaptersController());
      }),
    ),
    GetPage(
      name: hadithDetails,
      page: () => HadithDetailsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HadithDetailsController());
      }),
    ),
  ];
}