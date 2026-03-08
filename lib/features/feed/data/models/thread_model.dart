import 'package:aspira/features/feed/data/models/thread_author_model.dart';
import 'package:aspira/features/feed/data/models/thread_child_model.dart';
import 'package:aspira/features/feed/data/models/thread_count_model.dart';
import 'package:aspira/features/feed/domain/entities/thread_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread_model.g.dart';

@JsonSerializable()
class ThreadModel extends ThreadEntity {
  @override
  final ThreadAuthorModel? author;
  
  @override
  final List<ThreadChildModel>? children;
  
  @override
  @JsonKey(name: '_count')
  final ThreadCountModel? count;

  const ThreadModel({
    super.id,
    super.content,
    super.authorId,
    super.postId,
    super.parentId,
    super.createdAt,
    super.updatedAt,
    this.author,
    this.children,
    this.count,
  });

  factory ThreadModel.fromJson(Map<String, dynamic> json) {
    return _$ThreadModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThreadModelToJson(this);
}
