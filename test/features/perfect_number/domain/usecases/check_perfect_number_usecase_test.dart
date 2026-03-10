import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/check_perfect_number_usecase.dart';

void main() {
  late CheckPerfectNumberUsecase usecase;

  setUp(() {
    usecase = CheckPerfectNumberUsecase();
  });

  group('CheckPerfectNumberUsecase', () {
    group('known perfect numbers', () {
      test('6 is perfect', () => expect(usecase(6), isTrue));
      test('28 is perfect', () => expect(usecase(28), isTrue));
      test('496 is perfect', () => expect(usecase(496), isTrue));
      test('8128 is perfect', () => expect(usecase(8128), isTrue));
    });

    group('non-perfect numbers', () {
      test('1 is not perfect', () => expect(usecase(1), isFalse));
      test('2 is not perfect', () => expect(usecase(2), isFalse));
      test('12 is not perfect', () => expect(usecase(12), isFalse));
      test('100 is not perfect', () => expect(usecase(100), isFalse));
    });

    group('edge cases', () {
      test('0 is not perfect', () => expect(usecase(0), isFalse));
      test(
        'negative number is not perfect',
        () => expect(usecase(-6), isFalse),
      );
    });
  });
}
