import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_numbers/core/l10n/l10n_keys.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/perfect_number_result_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/check_perfect_number_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/find_perfect_numbers_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/get_history_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/save_search_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';

class PerfectNumberCubit extends Cubit<PerfectNumberState> {
  final SaveSearchUsecase _saveSearch;
  final GetHistoryUsecase _getHistory;

  PerfectNumberCubit({
    required CheckPerfectNumberUsecase checkPerfectNumber,
    required FindPerfectNumbersUsecase findPerfectNumbers,
    required SaveSearchUsecase saveSearch,
    required GetHistoryUsecase getHistory,
  }) : _saveSearch = saveSearch,
       _getHistory = getHistory,
       super(const PerfectNumberInitial());

  void reset() => emit(const PerfectNumberInitial());

  Future<void> checkNumber(String raw) async {
    final number = int.tryParse(raw.trim());
    if (number == null) {
      emit(const PerfectNumberError(message: L10nKeys.errorInvalidNumber));
      return;
    }

    emit(const PerfectNumberLoading());
    try {
      final isPerfect = await compute(_runCheck, number);
      final divisors = await compute(_runGetDivisors, number);

      await _saveSearch(
        SearchRecordEntity(
          id: 0,
          type: 'check',
          input: '$number',
          result: '$isPerfect',
          createdAt: DateTime.now(),
        ),
      );

      emit(
        CheckPerfectNumberSuccess(
          result: PerfectNumberResult(
            number: number,
            isPerfect: isPerfect,
            divisors: divisors,
          ),
        ),
      );
    } catch (e) {
      emit(PerfectNumberError(message: e.toString()));
    }
  }

  Future<void> findInRange(String rawStart, String rawEnd) async {
    final start = int.tryParse(rawStart.trim());
    final end = int.tryParse(rawEnd.trim());

    if (start == null || end == null) {
      emit(const PerfectNumberError(message: L10nKeys.errorInvalidRange));
      return;
    }
    if (start >= end) {
      emit(const PerfectNumberError(message: L10nKeys.errorStartBeforeEnd));
      return;
    }

    emit(const PerfectNumberLoading());
    try {
      final numbers = await compute(_runFind, _FindParams(start, end));
      final results = numbers
          .map(
            (n) => PerfectNumberResult(
              number: n,
              isPerfect: true,
              divisors: _runGetDivisors(n),
            ),
          )
          .toList();

      await _saveSearch(
        SearchRecordEntity(
          id: 0,
          type: 'range',
          input: '$start-$end',
          result: numbers.join(', '),
          createdAt: DateTime.now(),
        ),
      );

      emit(
        FindPerfectNumbersSuccess(
          rangeStart: start,
          rangeEnd: end,
          results: results,
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

bool _runCheck(int n) => CheckPerfectNumberUsecase()(n);

List<int> _runGetDivisors(int n) {
  const divisorThreshold = 1000000000; //1 bi
  if (n > divisorThreshold) return [];

  if (n < 2) return [];
  final divisors = <int>[1];
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) {
      divisors.add(i);
      if (i != n ~/ i) divisors.add(n ~/ i);
    }
  }
  divisors.sort();
  return divisors;
}

List<int> _runFind(_FindParams params) =>
    FindPerfectNumbersUsecase()(params.start, params.end);

class _FindParams {
  final int start;
  final int end;
  const _FindParams(this.start, this.end);
}
