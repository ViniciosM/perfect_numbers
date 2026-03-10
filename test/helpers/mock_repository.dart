import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/repositories/perfect_number_repository.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/get_history_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/save_search_usecase.dart';

class MockPerfectNumberRepository extends Mock
    implements PerfectNumberRepository {}

class MockSaveSearchUsecase extends Mock implements SaveSearchUsecase {}

class MockGetHistoryUsecase extends Mock implements GetHistoryUsecase {}

void registerFallbacks() {
  registerFallbackValue(
    SearchRecordEntity(
      id: 0,
      type: 'check',
      input: '6',
      result: 'true',
      createdAt: DateTime(2024),
    ),
  );
}
