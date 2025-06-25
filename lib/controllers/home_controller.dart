import 'package:get/get.dart';
import '../data/database/app_database.dart';
import '../data/repository/hadith_repository.dart';

class HomeController extends GetxController {
  final HadithRepository _repository = Get.find<HadithRepository>();
  final RxList<Book> books = <Book>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  Future<void> loadBooks() async {
    try {
      isLoading.value = true;
      error.value = '';
      final result = await _repository.getAllBooks();
      books.assignAll(result);
    } catch (e) {
      error.value = 'Failed to load books: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void goToChapters(Book book) {
    Get.toNamed('/chapters', arguments: book);
  }

  Future<void> refreshBooks() async {
    await loadBooks();
  }
}
