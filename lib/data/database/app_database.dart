import 'dart:developer';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Books, Chapters, Hadiths])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await _copyDatabaseFromAssets();
        },
      );

  Future<void> _copyDatabaseFromAssets() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hadith.db'));

    log('Database path: ${file.path}'); // Add this line

    if (await file.exists()) {
      log('Database does not exist, copying from assets...');
      final data = await rootBundle.load('assets/database/hadith.db');
      final bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes);
      log('Database copied successfully');
    } else {
      log('Database already exists');
    }
  }

  Future<List<Book>> getAllBooks() async {
    return await select(books).get();
  }

  Future<List<Chapter>> getChaptersByBookId(int bookId) async {
    return await (select(chapters)..where((tbl) => tbl.bookId.equals(bookId)))
        .get();
  }

  Future<List<Hadith>> getHadithsByChapterId(int chapterId) async {
    return await (select(hadiths)
          ..where((tbl) => tbl.chapterId.equals(chapterId)))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hadith.db'));
    return NativeDatabase(file);
  });
}
