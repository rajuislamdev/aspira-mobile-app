import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';
import 'count.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Equatable {
  final String? id;
  final String? title;
  final String? content;
  final dynamic mediaUrl;
  final int? shareCount;
  final String? authorId;
  final String? interestId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Author? author;
  @JsonKey(name: '_count')
  Count? count;
  bool hasReacted;

  PostModel({
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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return _$PostModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    dynamic mediaUrl,
    int? shareCount,
    String? authorId,
    String? interestId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Author? author,
    Count? count,
    bool? hasReacted,
  }) {
    return PostModel(
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
