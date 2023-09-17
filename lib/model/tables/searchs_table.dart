import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../base/search.dart';

@DataClassName('Searchs')
class SearchsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get searchId => integer().withDefault(const Constant(0))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get created => text().withDefault(const Constant(''))();
}

extension SearchsExtension on Searchs {
  Search getModel() => Search(
        id: id,
        searchId: searchId,
        title: title,
        created: created,
      );
}

extension SearchExtension on Search {
  SearchsTableCompanion getDbModel() {
    final id = this.id;
    return SearchsTableCompanion.insert(
      id: id == null ? const Value.absent() : Value(id),
      searchId: Value(searchId!),
      title: Value(title!),
      created: Value(created!),
    );
  }
}
