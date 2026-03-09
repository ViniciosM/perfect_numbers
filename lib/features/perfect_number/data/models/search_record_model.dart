import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';

class SearchRecordModel {
  final int? id;
  final String type;
  final String input;
  final String result;
  final DateTime createdAt;

  const SearchRecordModel({
    this.id,
    required this.type,
    required this.input,
    required this.result,
    required this.createdAt,
  });

  factory SearchRecordModel.fromMap(Map<String, dynamic> map) {
    return SearchRecordModel(
      id: map['id'] as int,
      type: map['type'] as String,
      input: map['input'] as String,
      result: map['result'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'input': input,
      'result': result,
      'created_at': createdAt.toIso8601String(),
    };
  }

  SearchRecordEntity toEntity() {
    return SearchRecordEntity(
      id: id ?? 0,
      type: type,
      input: input,
      result: result,
      createdAt: createdAt,
    );
  }

  factory SearchRecordModel.fromEntity(SearchRecordEntity entity) {
    return SearchRecordModel(
      id: entity.id == 0 ? null : entity.id,
      type: entity.type,
      input: entity.input,
      result: entity.result,
      createdAt: entity.createdAt,
    );
  }
}
