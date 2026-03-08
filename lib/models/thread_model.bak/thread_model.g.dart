// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadModel _$ThreadModelFromJson(Map<String, dynamic> json) => ThreadModel(
  id: json['id'] as String?,
  content: json['content'] as String?,
  authorId: json['authorId'] as String?,
  postId: json['postId'] as String?,
  parentId: json['parentId'],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  author: json['author'] == null
      ? null
      : Author.fromJson(json['author'] as Map<String, dynamic>),
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
      .toList(),
  count: json['_count'] == null
      ? null
      : Count.fromJson(json['_count'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ThreadModelToJson(ThreadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'authorId': instance.authorId,
      'postId': instance.postId,
      'parentId': instance.parentId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'author': instance.author,
      'children': instance.children,
      '_count': instance.count,
    };
