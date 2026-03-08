// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadCountModel _$ThreadCountModelFromJson(Map<String, dynamic> json) =>
    ThreadCountModel(
      reactions: (json['reactions'] as num?)?.toInt(),
      replies: (json['replies'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ThreadCountModelToJson(ThreadCountModel instance) =>
    <String, dynamic>{
      'reactions': instance.reactions,
      'replies': instance.replies,
    };
