import 'package:perfect_numbers/features/perfect_number/domain/usecases/check_perfect_number_usecase.dart';

class FindPerfectNumbersUsecase {
  List<int> call(int start, int end) => List.generate(
    end - start + 1,
    (i) => start + i,
  ).where((n) => CheckPerfectNumberUsecase()(n)).toList();
}
