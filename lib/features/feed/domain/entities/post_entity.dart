import 'package:equatable/equatable.dart';

import 'author_entity.dart';
import 'count_entity.dart';

class PostEntity extends Equatable {
  final String? id;
  final String? title;
  final String? content;
  final dynamic mediaUrl;
  final int? shareCount;
  final String? authorId;
  final String? interestId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final AuthorEntity? author;
  final CountEntity? count;
  final bool hasReacted;

  const PostEntity({
    this.id,
    this.title,
    this.content,
    this.mediaUrl,
    this.shareCount,
    this.authorId,
    this.interestId,
    this.createdAt,
    this.updatedAt,
    this.author,
    this.count,
    this.hasReacted = false,
  });

  PostEntity copyWith({
    String? id,
    String? title,
    String? content,
    dynamic mediaUrl,
    int? shareCount,
    String? authorId,
    String? interestId,
    DateTime? createdAt,
    DateTime? updatedAt,
    AuthorEntity? author,
    CountEntity? count,
    bool? hasReacted,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      shareCount: shareCount ?? this.shareCount,
      authorId: authorId ?? this.authorId,
      interestId: interestId ?? this.interestId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
      count: count ?? this.count,
      hasReacted: hasReacted ?? this.hasReacted,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      content,
      mediaUrl,
      shareCount,
      authorId,
      interestId,
      createdAt,
      updatedAt,
      author,
      count,
      hasReacted,
    ];
  }
}
