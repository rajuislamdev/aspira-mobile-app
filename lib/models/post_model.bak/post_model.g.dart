// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  content: json['content'] as String?,
  mediaUrl: json['mediaUrl'],
  shareCount: (json['shareCount'] as num?)?.toInt(),
  authorId: json['authorId'] as String?,
  interestId: json['interestId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  author: json['author'] == null
      ? null
      : Author.fromJson(json['author'] as Map<String, dynamic>),
  count: json['_count'] == null
      ? null
      : Count.fromJson(json['_count'] as Map<String, dynamic>),
  hasReacted: json['hasReacted'] as bool? ?? false,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'mediaUrl': instance.mediaUrl,
  'shareCount': instance.shareCount,
  'authorId': instance.authorId,
  'interestId': instance.interestId,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'author': instance.author,
  '_count': instance.count,
  'hasReacted': instance.hasReacted,
};
