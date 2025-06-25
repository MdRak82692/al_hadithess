import 'package:get/get.dart';
import '../database/app_database.dart';

class HadithRepository extends GetxService {
  final AppDatabase _database;

  HadithRepository(this._database);

  Future<List<Book>> getAllBooks() async {
    return await _database.getAllBooks();
  }

  Future<List<Chapter>> getChaptersByBookId(int bookId) async {
    return await _database.getChaptersByBookId(bookId);
  }

  Future<List<Hadith>> getHadithsByChapterId(int chapterId) async {
    return await _database.getHadithsByChapterId(chapterId);
  }
}
