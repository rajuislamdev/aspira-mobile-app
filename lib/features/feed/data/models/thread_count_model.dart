import 'package:aspira/features/feed/domain/entities/thread_count_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread_count_model.g.dart';

@JsonSerializable()
class ThreadCountModel extends ThreadCountEntity {
  const ThreadCountModel({super.reactions, super.replies});

  factory ThreadCountModel.fromJson(Map<String, dynamic> json) {
    return _$ThreadCountModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThreadCountModelToJson(this);
}
