import 'package:aspira/features/feed/data/models/thread_author_model.dart';
import 'package:aspira/features/feed/domain/entities/thread_child_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread_child_model.g.dart';

@JsonSerializable()
class ThreadChildModel extends ThreadChildEntity {
  @override
  final ThreadAuthorModel? author;
  
  @override
  final List<ThreadChildModel>? children;

  const ThreadChildModel({
    super.id,
    super.content,
    super.authorId,
    super.postId,
    super.parentId,
    super.createdAt,
    super.updatedAt,
    this.author,
    this.children,
  });

  factory ThreadChildModel.fromJson(Map<String, dynamic> json) {
    return _$ThreadChildModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThreadChildModelToJson(this);
}
