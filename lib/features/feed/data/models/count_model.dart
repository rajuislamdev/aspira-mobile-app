import 'package:aspira/features/feed/domain/entities/count_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'count_model.g.dart';

@JsonSerializable()
class CountModel extends CountEntity {
  const CountModel({
    super.reactions,
    super.replies,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) {
    return _$CountModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CountModelToJson(this);

  @override
  CountModel copyWith({
    int? reactions,
    int? replies,
  }) {
    return CountModel(
      reactions: reactions ?? this.reactions,
      replies: replies ?? this.replies,
    );
  }
}
