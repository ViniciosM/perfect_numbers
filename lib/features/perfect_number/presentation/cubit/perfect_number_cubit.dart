import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/check_perfect_number_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/find_perfect_numbers_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/get_history_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/save_search_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';

class PerfectNumberCubit extends Cubit<PerfectNumberState> {
  final CheckPerfectNumberUsecase _checkPerfectNumber;
  final FindPerfectNumbersUsecase _findPerfectNumbers;
  final SaveSearchUsecase _saveSearch;
  final GetHistoryUsecase _getHistory;

  PerfectNumberCubit({
    required CheckPerfectNumberUsecase checkPerfectNumber,
    required FindPerfectNumbersUsecase findPerfectNumbers,
    required SaveSearchUsecase saveSearch,
    required GetHistoryUsecase getHistory,
  }) : _checkPerfectNumber = checkPerfectNumber,
       _findPerfectNumbers = findPerfectNumbers,
       _saveSearch = saveSearch,
       _getHistory = getHistory,
       super(const PerfectNumberInitial());

  Future<void> checkNumber(int number) async {
    emit(const PerfectNumberLoading());
    try {
      final isPerfect = _checkPerfectNumber(number);

      await _saveSearch(
        SearchRecord(
          id: 0,
          type: 'check',
          input: '$number',
          result: '$isPerfect',
          createdAt: DateTime.now(),
        ),
      );

      emit(CheckPerfectNumberSuccess(number: number, isPerfect: isPerfect));
    } catch (e) {
      emit(PerfectNumberError(message: e.toString()));
    }
  }

  Future<void> findInRange(int start, int end) async {
    emit(const PerfectNumberLoading());
    try {
      final perfectNumbers = _findPerfectNumbers(start, end);

      await _saveSearch(
        SearchRecord(
          id: 0,
          type: 'range',
          input: '$start-$end',
          result: perfectNumbers.join(', '),
          createdAt: DateTime.now(),
        ),
      );

      emit(
        FindPerfectNumbersSuccess(
          start: start,
          end: end,
          perfectNumbers: perfectNumbers,
        ),
      );
    } catch (e) {
      emit(PerfectNumberError(message: e.toString()));
    }
  }

  Future<void> loadHistory() async {
    emit(const PerfectNumberLoading());
    try {
      final records = await _getHistory();
      emit(HistoryLoaded(records: records));
    } catch (e) {
      emit(PerfectNumberError(message: e.toString()));
    }
  }
}
