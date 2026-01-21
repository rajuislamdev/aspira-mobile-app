// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Count _$CountFromJson(Map<String, dynamic> json) => Count(
  reactions: (json['reactions'] as num?)?.toInt(),
  replies: (json['replies'] as num?)?.toInt(),
);

Map<String, dynamic> _$CountToJson(Count instance) => <String, dynamic>{
  'reactions': instance.reactions,
  'replies': instance.replies,
};
