import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/save_search_usecase.dart';
import '../../../../helpers/mock_repository.dart';

void main() {
  late SaveSearchUsecase usecase;
  late MockPerfectNumberRepository mockRepository;

  setUp(() {
    registerFallbacks();
    mockRepository = MockPerfectNumberRepository();
    usecase = SaveSearchUsecase(mockRepository);
  });

  group('SaveSearchUsecase', () {
    test('calls repository.saveSearch with correct record', () async {
      final record = SearchRecordEntity(
        id: 0,
        type: 'check',
        input: '6',
        result: 'true',
        createdAt: DateTime(2024),
      );

      when(() => mockRepository.saveSearch(record)).thenAnswer((_) async {});

      await usecase(record);

      verify(() => mockRepository.saveSearch(record)).called(1);
    });
  });
}
