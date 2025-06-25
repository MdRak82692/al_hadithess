import 'package:get/get.dart';
import '../data/database/app_database.dart';
import '../data/repository/hadith_repository.dart';

class ChaptersController extends GetxController {
  final HadithRepository _repository = Get.find<HadithRepository>();
  final RxList<Chapter> chapters = <Chapter>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<Book?> selectedBook = Rx<Book?>(null);

  @override
  void onInit() {
    super.onInit();
    final book = Get.arguments as Book?;
    if (book != null) {
      selectedBook.value = book;
      loadChapters(book.id);
    } else {
      error.value = 'No book selected';
    }
  }

  Future<void> loadChapters(int bookId) async {
    try {
      isLoading.value = true;
      error.value = '';
      final result = await _repository.getChaptersByBookId(bookId);
      chapters.assignAll(result);
    } catch (e) {
      error.value = 'Failed to load chapters: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void goToHadithDetails(Chapter chapter) {
    Get.toNamed('/hadith-details', arguments: {
      'chapter': chapter,
      'book': selectedBook.value,
    });
  }

  Future<void> refreshChapters() async {
    if (selectedBook.value != null) {
      await loadChapters(selectedBook.value!.id);
    }
  }
}
