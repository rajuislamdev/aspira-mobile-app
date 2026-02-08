import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';

part 'child.g.dart';

@JsonSerializable()
class Child extends Equatable {
  final String? id;
  final String? content;
  final String? authorId;
  final String? postId;
  final String? parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Author? author;
  final List<Child>? children;

  const Child({
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

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  Map<String, dynamic> toJson() => _$ChildToJson(this);

  Child copyWith({
    String? id,
    String? content,
    String? authorId,
    String? postId,
    String? parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Author? author,
    List<Child>? children,
  }) {
    return Child(
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
