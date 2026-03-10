import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/find_perfect_numbers_usecase.dart';

void main() {
  late FindPerfectNumbersUsecase usecase;

  setUp(() {
    usecase = FindPerfectNumbersUsecase();
  });

  group('FindPerfectNumbersUsecase', () {
    test('finds 6 and 28 in range 1–100', () {
      expect(usecase(1, 100), equals([6, 28]));
    });

    test('finds 6, 28, 496, 8128 in range 1–10000', () {
      expect(usecase(1, 10000), equals([6, 28, 496, 8128]));
    });

    test('returns empty list when no perfect numbers in range', () {
      expect(usecase(7, 27), isEmpty);
    });

    test('returns single result when range contains exactly one', () {
      expect(usecase(6, 6), equals([6]));
    });

    test('returns empty when range is above all known small perfects', () {
      expect(usecase(8129, 9000), isEmpty);
    });
  });
}
