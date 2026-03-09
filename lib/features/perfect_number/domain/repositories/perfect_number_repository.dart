import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';

abstract class PerfectNumberRepository {
  Future<void> saveSearch(SearchRecord record);
  Future<List<SearchRecord>> getHistory();
}
