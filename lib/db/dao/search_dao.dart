import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../models/base/search.dart';
import '../../models/tables/db_search_table.dart';
import '../songlib_db.dart';

part 'search_dao.g.dart';

@lazySingleton
abstract class SearchDao {
  @factoryMethod
  factory SearchDao(SongLibDB db) = _SearchDao;

  Future<List<Search>> getAllSearches();
  Future<void> createSearch(Search search);
  Future<void> deleteSearch(Search search);
}

@DriftAccessor(tables: [
  DbSearchTable,
])
class _SearchDao extends DatabaseAccessor<SongLibDB>
    with _$_SearchDaoMixin
    implements SearchDao {
  _SearchDao(SongLibDB db) : super(db);

  @override
  Future<List<Search>> getAllSearches() async {
    return await customSelect(
      'SELECT * FROM ${db.dbSearchTable.actualTableName} '
      'ORDER BY ${db.dbSearchTable.id.name} DESC;',
      readsFrom: {db.dbSearchTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => Search.fromData(row.data)).toList();
      },
    ).first;
  }

  @override
  Future<void> createSearch(Search search) => into(db.dbSearchTable).insert(
        DbSearchTableCompanion.insert(
          objectId: Value(search.objectId!),
          title: Value(search.title!),
          createdAt: Value(search.createdAt!),
        ),
      );

  @override
  Future<void> deleteSearch(Search search) =>
      (delete(db.dbSearchTable)..where((row) => row.id.equals(search.id!))).go();
}
