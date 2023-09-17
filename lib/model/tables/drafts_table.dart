import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../base/draft.dart';

@DataClassName('Drafts')
class DraftsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get draftId => integer().withDefault(const Constant(0))();
  IntColumn get user => integer().withDefault(const Constant(0))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get alias => text().withDefault(const Constant(''))();
  TextColumn get content => text().withDefault(const Constant(''))();
  TextColumn get key => text().withDefault(const Constant(''))();
  TextColumn get created => text().withDefault(const Constant(''))();
  TextColumn get updated => text().withDefault(const Constant(''))();
}

extension DraftsExtension on Drafts {
  Draft getModel() => Draft(
        id: id,
        draftId: draftId,
        user: user,
        title: title,
        alias: alias,
        content: content,
        key: key,
        created: created,
        updated: updated,
      );
}

extension DraftExtension on Draft {
  DraftsTableCompanion getDbModel() {
    final id = this.id;
    return DraftsTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
          draftId: Value(draftId!),
          user: Value(user!),
          title: Value(title!),
          alias: Value(alias!),
          content: Value(content!),
          key: Value(key!),
          created: Value(created!),
          updated: Value(updated!),
    );
  }
}
