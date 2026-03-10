import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/get_history_usecase.dart';
import '../../../../helpers/mock_repository.dart';

void main() {
  late GetHistoryUsecase usecase;
  late MockPerfectNumberRepository mockRepository;

  setUp(() {
    mockRepository = MockPerfectNumberRepository();
    usecase = GetHistoryUsecase(mockRepository);
  });

  group('GetHistoryUsecase', () {
    test('returns list from repository', () async {
      final records = [
        SearchRecordEntity(
          id: 1,
          type: 'check',
          input: '6',
          result: 'true',
          createdAt: DateTime(2024),
        ),
      ];

      when(() => mockRepository.getHistory()).thenAnswer((_) async => records);

      final result = await usecase();

      expect(result, equals(records));
      verify(() => mockRepository.getHistory()).called(1);
    });

    test('returns empty list when history is empty', () async {
      when(() => mockRepository.getHistory()).thenAnswer((_) async => []);

      final result = await usecase();

      expect(result, isEmpty);
    });
  });
}
