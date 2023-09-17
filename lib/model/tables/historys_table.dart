import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../base/history.dart';

@DataClassName('Historys')
class HistorysTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get historyId => integer().withDefault(const Constant(0))();
  IntColumn get song => integer().withDefault(const Constant(0))();
  TextColumn get created => text().withDefault(const Constant(''))();
}

extension HistorysExtension on Historys {
  History getModel() => History(
        id: id,
        historyId: historyId,
        song: song,
        created: created,
      );
}

extension HistoryExtension on History {
  HistorysTableCompanion getDbModel() {
    final id = this.id;
    return HistorysTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
      historyId: Value(historyId!),
      song: Value(song!),
      created: Value(created!),
    );
  }
}
