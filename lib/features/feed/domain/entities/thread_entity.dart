import 'package:equatable/equatable.dart';

import 'thread_author_entity.dart';
import 'thread_child_entity.dart';
import 'thread_count_entity.dart';

class ThreadEntity extends Equatable {
  final String? id;
  final String? content;
  final String? authorId;
  final String? postId;
  final dynamic parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ThreadAuthorEntity? author;
  final List<ThreadChildEntity>? children;
  final ThreadCountEntity? count;

  const ThreadEntity({
    this.id,
    this.content,
    this.authorId,
    this.postId,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.author,
    this.children,
    this.count,
  });

  ThreadEntity copyWith({
    String? id,
    String? content,
    String? authorId,
    String? postId,
    dynamic parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    ThreadAuthorEntity? author,
    List<ThreadChildEntity>? children,
    ThreadCountEntity? count,
  }) {
    return ThreadEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      postId: postId ?? this.postId,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
      children: children ?? this.children,
      count: count ?? this.count,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      content,
      authorId,
      postId,
      parentId,
      createdAt,
      updatedAt,
      author,
      children,
      count,
    ];
  }
}
