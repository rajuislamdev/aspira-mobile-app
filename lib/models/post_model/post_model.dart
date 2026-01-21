import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';
import 'count.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Equatable {
  final String? id;
  final String? content;
  final dynamic mediaUrl;
  final int? shareCount;
  final String? authorId;
  final String? interestId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Author? author;
  @JsonKey(name: '_count')
  final Count? count;

  const PostModel({
    this.id,
    this.content,
    this.mediaUrl,
    this.shareCount,
    this.authorId,
    this.interestId,
    this.createdAt,
    this.updatedAt,
    this.author,
    this.count,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return _$PostModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  PostModel copyWith({
    String? id,
    String? content,
    dynamic mediaUrl,
    int? shareCount,
    String? authorId,
    String? interestId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Author? author,
    Count? count,
  }) {
    return PostModel(
      id: id ?? this.id,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      shareCount: shareCount ?? this.shareCount,
      authorId: authorId ?? this.authorId,
      interestId: interestId ?? this.interestId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
      count: count ?? this.count,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      content,
      mediaUrl,
      shareCount,
      authorId,
      interestId,
      createdAt,
      updatedAt,
      author,
      count,
    ];
  }
}
