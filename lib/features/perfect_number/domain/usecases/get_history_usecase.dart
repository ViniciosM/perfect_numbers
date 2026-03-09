import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/repositories/perfect_number_repository.dart';

class GetHistoryUsecase {
  final PerfectNumberRepository _repository;

  GetHistoryUsecase(this._repository);

  Future<List<SearchRecord>> call() => _repository.getHistory();
}
