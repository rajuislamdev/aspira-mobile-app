import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'count.g.dart';

@JsonSerializable()
class Count extends Equatable {
  final int? reactions;
  final int? replies;

  const Count({this.reactions, this.replies});

  factory Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);

  Map<String, dynamic> toJson() => _$CountToJson(this);

  Count copyWith({int? reactions, int? replies}) {
    return Count(
      reactions: reactions ?? this.reactions,
      replies: replies ?? this.replies,
    );
  }

  @override
  List<Object?> get props => [reactions, replies];
}
