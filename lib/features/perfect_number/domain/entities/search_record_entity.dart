import 'package:equatable/equatable.dart';

class SearchRecordEntity extends Equatable {
  final int id;
  final String type;
  final String input;
  final String result;
  final DateTime createdAt;

  const SearchRecordEntity({
    required this.id,
    required this.type,
    required this.input,
    required this.result,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, input, result, createdAt];
}
