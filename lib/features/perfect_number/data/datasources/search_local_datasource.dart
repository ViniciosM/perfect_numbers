import 'package:perfect_numbers/core/db/database_helper.dart';
import 'package:perfect_numbers/features/perfect_number/data/models/search_record_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class SearchLocalDatasource {
  Future<void> insertSearch(SearchRecordModel model);
  Future<List<SearchRecordModel>> getAllSearches();
}

class SearchLocalDatasourceImpl implements SearchLocalDatasource {
  final DatabaseHelper _databaseHelper;

  SearchLocalDatasourceImpl(this._databaseHelper);

  @override
  Future<void> insertSearch(SearchRecordModel model) async {
    final db = await _databaseHelper.database;
    await db.insert(
      DatabaseHelper.tableSearchHistory,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<SearchRecordModel>> getAllSearches() async {
    final db = await _databaseHelper.database;
    final rows = await db.query(
      DatabaseHelper.tableSearchHistory,
      orderBy: 'created_at DESC',
    );
    return rows.map((row) => SearchRecordModel.fromMap(row)).toList();
  }
}
