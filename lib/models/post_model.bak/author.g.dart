// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  profilePicture: json['profilePicture'],
);

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profilePicture': instance.profilePicture,
};
