import 'package:equatable/equatable.dart';

import 'thread_author_entity.dart';

class ThreadChildEntity extends Equatable {
  final String? id;
  final String? content;
  final String? authorId;
  final String? postId;
  final String? parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ThreadAuthorEntity? author;
  final List<ThreadChildEntity>? children;

  const ThreadChildEntity({
    this.id,
    this.content,
    this.authorId,
    this.postId,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.author,
    this.children,
  });

  ThreadChildEntity copyWith({
    String? id,
    String? content,
    String? authorId,
    String? postId,
    String? parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    ThreadAuthorEntity? author,
    List<ThreadChildEntity>? children,
  }) {
    return ThreadChildEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      postId: postId ?? this.postId,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
      children: children ?? this.children,
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
    ];
  }
}
