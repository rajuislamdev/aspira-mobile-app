import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';
import 'child.dart';
import 'count.dart';

part 'thread_model.g.dart';

@JsonSerializable()
class ThreadModel extends Equatable {
  final String? id;
  final String? content;
  final String? authorId;
  final String? postId;
  final dynamic parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Author? author;
  final List<Child>? children;
  @JsonKey(name: '_count')
  final Count? count;

  const ThreadModel({
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

  factory ThreadModel.fromJson(Map<String, dynamic> json) {
    return _$ThreadModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThreadModelToJson(this);

  ThreadModel copyWith({
    String? id,
    String? content,
    String? authorId,
    String? postId,
    dynamic parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Author? author,
    List<Child>? children,
    Count? count,
  }) {
    return ThreadModel(
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
