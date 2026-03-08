import 'package:aspira/features/feed/domain/entities/thread_author_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread_author_model.g.dart';

@JsonSerializable()
class ThreadAuthorModel extends ThreadAuthorEntity {
  const ThreadAuthorModel({
    super.firstName,
    super.lastName,
    super.profilePicture,
  });

  factory ThreadAuthorModel.fromJson(Map<String, dynamic> json) {
    return _$ThreadAuthorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThreadAuthorModelToJson(this);

  @override
  ThreadAuthorModel copyWith({
    String? firstName,
    String? lastName,
    dynamic profilePicture,
  }) {
    return ThreadAuthorModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
