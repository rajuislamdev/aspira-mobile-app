// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountModel _$CountModelFromJson(Map<String, dynamic> json) => CountModel(
  reactions: (json['reactions'] as num?)?.toInt(),
  replies: (json['replies'] as num?)?.toInt(),
);

Map<String, dynamic> _$CountModelToJson(CountModel instance) =>
    <String, dynamic>{
      'reactions': instance.reactions,
      'replies': instance.replies,
    };
