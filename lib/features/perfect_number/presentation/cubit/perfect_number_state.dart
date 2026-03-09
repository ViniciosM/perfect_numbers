import 'package:equatable/equatable.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/perfect_number_result_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';

abstract class PerfectNumberState extends Equatable {
  const PerfectNumberState();

  @override
  List<Object?> get props => [];
}

class PerfectNumberInitial extends PerfectNumberState {
  const PerfectNumberInitial();
}

class PerfectNumberLoading extends PerfectNumberState {
  const PerfectNumberLoading();
}

class CheckPerfectNumberSuccess extends PerfectNumberState {
  final PerfectNumberResult result;

  const CheckPerfectNumberSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class FindPerfectNumbersSuccess extends PerfectNumberState {
  final int rangeStart;
  final int rangeEnd;
  final List<PerfectNumberResult> results;

  const FindPerfectNumbersSuccess({
    required this.rangeStart,
    required this.rangeEnd,
    required this.results,
  });

  @override
  List<Object?> get props => [rangeStart, rangeEnd, results];
}

class HistoryLoaded extends PerfectNumberState {
  final List<SearchRecordEntity> records;

  const HistoryLoaded({required this.records});

  @override
  List<Object?> get props => [records];
}

class PerfectNumberError extends PerfectNumberState {
  final String message;

  const PerfectNumberError({required this.message});

  @override
  List<Object?> get props => [message];
}
