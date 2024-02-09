import 'dart:ui';

export 'dart:ui' show Color;

import 'package:drift/drift.dart';

@DataClassName('TodoEntry')
class TodoEntries extends Table with AutoIncrementingPrimaryKey {
  TextColumn get description => text()();
  IntColumn get category => integer().nullable().references(Categories, #id)();

  DateTimeColumn get dueDate => dateTime().nullable()();
}

@DataClassName('Category')
class Categories extends Table with AutoIncrementingPrimaryKey {
  TextColumn get name => text()();
  IntColumn get color => integer().map(const ColorConverter())();
}

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}

class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromSql(int fromDb) => Color(fromDb);

  @override
  int toSql(Color value) => value.value;
}
