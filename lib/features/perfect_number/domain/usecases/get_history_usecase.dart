import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/repositories/perfect_number_repository.dart';

class GetHistoryUsecase {
  final PerfectNumberRepository _repository;

  GetHistoryUsecase(this._repository);

  Future<List<SearchRecordEntity>> call() => _repository.getHistory();
}
