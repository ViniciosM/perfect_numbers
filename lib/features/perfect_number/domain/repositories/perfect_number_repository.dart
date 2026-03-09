import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';

abstract class PerfectNumberRepository {
  Future<void> saveSearch(SearchRecordEntity record);
  Future<List<SearchRecordEntity>> getHistory();
}
