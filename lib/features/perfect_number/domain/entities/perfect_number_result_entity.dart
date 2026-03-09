import 'package:equatable/equatable.dart';

class PerfectNumberResult extends Equatable {
  final int number;
  final bool isPerfect;
  final List<int> divisors;

  const PerfectNumberResult({
    required this.number,
    required this.isPerfect,
    required this.divisors,
  });

  @override
  List<Object?> get props => [number, isPerfect, divisors];
}
