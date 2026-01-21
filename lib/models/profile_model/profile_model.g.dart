// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: json['id'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  position: json['position'] as String?,
  activeStatus: json['activeStatus'] as bool?,
  profilePicture: json['profilePicture'],
  experience: (json['experience'] as num?)?.toInt(),
  goal: (json['goal'] as num?)?.toInt(),
  interests: (json['interests'] as List<dynamic>?)
      ?.map((e) => Interest.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'position': instance.position,
      'activeStatus': instance.activeStatus,
      'profilePicture': instance.profilePicture,
      'experience': instance.experience,
      'goal': instance.goal,
      'interests': instance.interests,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
