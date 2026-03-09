import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/repositories/perfect_number_repository.dart';

class SaveSearchUsecase {
  final PerfectNumberRepository _repository;

  SaveSearchUsecase(this._repository);

  Future<void> call(SearchRecordEntity record) =>
      _repository.saveSearch(record);
}
