import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../base/listed.dart';

@DataClassName('Listeds')
class ListedsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get listedId => integer().withDefault(const Constant(0))();
  IntColumn get user => integer().withDefault(const Constant(0))();
  IntColumn get parentid => integer().withDefault(const Constant(0))();
  IntColumn get song => integer().withDefault(const Constant(0))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get position => integer().withDefault(const Constant(0))();
  TextColumn get created => text().withDefault(const Constant(''))();
  TextColumn get updated => text().withDefault(const Constant(''))();
}

extension ListedsExtension on Listeds {
  Listed getModel() => Listed(
        id: id,
        listedId: listedId,
        user: user,
        song: song,
        parentid: parentid,
        title: title,
        description: description,
        position: position,
        created: created,
        updated: updated,
      );
}

extension ListedExtension on Listed {
  ListedsTableCompanion getDbModel() {
    final id = this.id;
    return ListedsTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
      listedId: Value(listedId!),
      user: Value(user!),
      song: Value(song!),
      parentid: Value(parentid!),
      title: Value(title!),
      description: Value(description!),
      position: Value(position!),
      created: Value(created!),
      updated: Value(updated!),
    );
  }
}
