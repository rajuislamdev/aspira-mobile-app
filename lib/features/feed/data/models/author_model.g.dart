// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorModel _$AuthorModelFromJson(Map<String, dynamic> json) => AuthorModel(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  profilePicture: json['profilePicture'],
);

Map<String, dynamic> _$AuthorModelToJson(AuthorModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
    };
