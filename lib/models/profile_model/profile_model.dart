import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'interest.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? position;
  final bool? activeStatus;
  final dynamic profilePicture;
  final int? experience;
  final int? goal;
  final List<Interest>? interests;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.position,
    this.activeStatus,
    this.profilePicture,
    this.experience,
    this.goal,
    this.interests,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? position,
    bool? activeStatus,
    dynamic profilePicture,
    int? experience,
    int? goal,
    List<Interest>? interests,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      position: position ?? this.position,
      activeStatus: activeStatus ?? this.activeStatus,
      profilePicture: profilePicture ?? this.profilePicture,
      experience: experience ?? this.experience,
      goal: goal ?? this.goal,
      interests: interests ?? this.interests,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      position,
      activeStatus,
      profilePicture,
      experience,
      goal,
      interests,
      createdAt,
      updatedAt,
    ];
  }
}
