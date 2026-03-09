import 'package:perfect_numbers/features/perfect_number/domain/usecases/check_perfect_number_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final useCase = CheckPerfectNumberUsecase();
  test('6 is perfect', () => expect(useCase(6), true));
  test('28 is perfect', () => expect(useCase(28), true));
  test('496 is perfect', () => expect(useCase(496), true));
  test('12 is not perfect', () => expect(useCase(12), false));
  test('1 is not perfect', () => expect(useCase(1), false));
}
