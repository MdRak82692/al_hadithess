import 'package:drift/drift.dart';

class Books extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().named('title')();
  TextColumn get titleAr => text().named('title_ar')();
  IntColumn get numberOfHadis => integer().named('number_of_hadis')();
  TextColumn get abvrCode => text().named('abvr_code')();
  TextColumn get bookName => text().named('book_name')();
  TextColumn get bookDescr => text().named('book_descr')();
  TextColumn get colorCode => text().named('color_code')();

  @override
  Set<Column> get primaryKey => {id};
}

class Chapters extends Table {
  @override
  String get tableName => 'chapter';

  IntColumn get id => integer()();
  IntColumn get chapterId => integer().named('chapter_id')();
  IntColumn get bookId => integer().named('book_id')();
  TextColumn get title => text()();
  IntColumn get number => integer()();
  TextColumn get hadisRange => text().named('hadis_range').nullable()();
  TextColumn get bookName => text().named('book_name')();

  @override
  Set<Column> get primaryKey => {id};
}

class Hadiths extends Table {
  @override
  String get tableName => 'hadith';

  IntColumn get id => integer()();
  IntColumn get bookId => integer().named('book_id')();
  TextColumn get bookName => text().named('book_name')();
  IntColumn get chapterId => integer().named('chapter_id')();
  IntColumn get sectionId => integer().named('section_id').nullable()();
  TextColumn get hadithKey => text().named('hadith_key').nullable()();
  IntColumn get hadithId => integer().named('hadith_id')();

  // Make these nullable to avoid crash on NULL values
  TextColumn get narrator => text().nullable()();
  TextColumn get bn => text().nullable()();
  TextColumn get ar => text().nullable()();

  TextColumn get arDiacless => text().named('ar_diacless').nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get gradeId => integer().named('grade_id').nullable()();
  TextColumn get grade => text().nullable()();
  TextColumn get gradeColor => text().named('grade_color').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
