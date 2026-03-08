// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadAuthorModel _$ThreadAuthorModelFromJson(Map<String, dynamic> json) =>
    ThreadAuthorModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profilePicture: json['profilePicture'],
    );

Map<String, dynamic> _$ThreadAuthorModelToJson(ThreadAuthorModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
    };
