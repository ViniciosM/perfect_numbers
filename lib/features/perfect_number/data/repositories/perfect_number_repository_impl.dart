import 'package:perfect_numbers/features/perfect_number/data/datasources/search_local_datasource.dart';
import 'package:perfect_numbers/features/perfect_number/data/models/search_record_model.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/repositories/perfect_number_repository.dart';

class PerfectNumberRepositoryImpl implements PerfectNumberRepository {
  final SearchLocalDatasource _datasource;

  PerfectNumberRepositoryImpl(this._datasource);

  @override
  Future<void> saveSearch(SearchRecordEntity record) async {
    final model = SearchRecordModel.fromEntity(record);
    await _datasource.insertSearch(model);
  }

  @override
  Future<List<SearchRecordEntity>> getHistory() async {
    final models = await _datasource.getAllSearches();
    return models.map((m) => m.toEntity()).toList();
  }
}
