import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interest.g.dart';

@JsonSerializable()
class Interest extends Equatable {
  final String? id;
  final String? name;
  final String? categoryId;

  const Interest({this.id, this.name, this.categoryId});

  factory Interest.fromJson(Map<String, dynamic> json) {
    return _$InterestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InterestToJson(this);

  Interest copyWith({String? id, String? name, String? categoryId}) {
    return Interest(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [id, name, categoryId];
}
