import 'dart:developer';

import 'package:get/get.dart';
import '../data/database/app_database.dart';
import '../data/repository/hadith_repository.dart';

class HadithDetailsController extends GetxController {
  final HadithRepository _repository = Get.find<HadithRepository>();
  final RxList<Hadith> hadiths = <Hadith>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<Chapter?> selectedChapter = Rx<Chapter?>(null);
  final Rx<Book?> selectedBook = Rx<Book?>(null);
  final RxInt currentHadithIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args == null) {
        error.value = 'No arguments provided';
        return;
      }

      selectedChapter.value = args['chapter'] as Chapter?;
      selectedBook.value = args['book'] as Book?;

      if (selectedChapter.value == null || selectedChapter.value?.id == null) {
        error.value = 'Invalid or missing chapter data';
        log('Error: selectedChapter is null or has no ID');
        return;
      }

      loadHadiths(selectedChapter.value!.id);
    } catch (e, stackTrace) {
      error.value = 'Error initializing: $e';
      log('Initialization error: $e\n$stackTrace');
    }
  }

  Future<void> loadHadiths(int chapterId) async {
    try {
      isLoading.value = true;
      error.value = '';
      final result = await _repository.getHadithsByChapterId(chapterId);
      if (result.isEmpty) {
        error.value = 'No hadiths found for this chapter';
      }
      hadiths.assignAll(result);
    } catch (e, stackTrace) {
      log('Error loading hadiths: $e');
      log("$stackTrace");
      error.value = 'Failed to load hadiths: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Hadith? get currentHadith {
    if (hadiths.isEmpty || currentHadithIndex.value >= hadiths.length) {
      return null;
    }
    return hadiths[currentHadithIndex.value];
  }

  void nextHadith() {
    if (currentHadithIndex.value < hadiths.length - 1) {
      currentHadithIndex.value++;
    }
  }

  void previousHadith() {
    if (currentHadithIndex.value > 0) {
      currentHadithIndex.value--;
    }
  }

  Future<void> refreshHadiths() async {
    if (selectedChapter.value != null) {
      await loadHadiths(selectedChapter.value!.id);
    }
  }
}
