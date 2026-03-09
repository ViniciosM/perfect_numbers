import 'package:equatable/equatable.dart';
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
  final int number;
  final bool isPerfect;

  const CheckPerfectNumberSuccess({
    required this.number,
    required this.isPerfect,
  });

  @override
  List<Object?> get props => [number, isPerfect];
}

class FindPerfectNumbersSuccess extends PerfectNumberState {
  final int start;
  final int end;
  final List<int> perfectNumbers;

  const FindPerfectNumbersSuccess({
    required this.start,
    required this.end,
    required this.perfectNumbers,
  });

  @override
  List<Object?> get props => [start, end, perfectNumbers];
}

class HistoryLoaded extends PerfectNumberState {
  final List<SearchRecord> records;

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
