import 'package:aspira/features/feed/data/models/author_model.dart';
import 'package:aspira/features/feed/data/models/count_model.dart';
import 'package:aspira/features/feed/domain/entities/post_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity {
  @override
  final AuthorModel? author;

  @override
  @JsonKey(name: '_count')
  final CountModel? count;

  const PostModel({
    super.id,
    super.title,
    super.content,
    super.mediaUrl,
    super.shareCount,
    super.authorId,
    super.interestId,
    super.createdAt,
    super.updatedAt,
    this.author,
    this.count,
    super.hasReacted = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return _$PostModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
