import 'package:get/get.dart';
import '../data/repository/hadith_repository.dart';
import '../data/database/app_database.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize database
    Get.put(AppDatabase(), permanent: true);

    // Initialize repository
    Get.lazyPut(() => HadithRepository(Get.find<AppDatabase>()));
  }
}
