import 'package:aspira/features/auth/domain/entities/user_entity.dart';

class UserResponseModel extends UserEntity {
  UserResponseModel({
    required super.id,
    required super.email,
    super.firstName,
    super.lastName,
    super.profilePictureUrl,
    super.bio,
    super.dateOfBirth,
    super.gender,
    super.location,
    super.website,
    super.interests,
    super.createdAt,
    super.updatedAt,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      bio: json['bio'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      gender: json['gender'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      interests: json['interests'] != null
          ? List<String>.from(json['interests'] as List)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePictureUrl': profilePictureUrl,
      'bio': bio,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'location': location,
      'website': website,
      'interests': interests,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
