import 'package:equatable/equatable.dart';

import 'interest_entity.dart';

class ProfileEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? position;
  final bool? activeStatus;
  final String? bio;
  final dynamic profilePicture;
  final int? experience;
  final int? goal;
  final List<InterestEntity>? interests;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProfileEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.position,
    this.activeStatus,
    this.profilePicture,
    this.bio,
    this.experience,
    this.goal,
    this.interests,
    this.createdAt,
    this.updatedAt,
  });

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
      bio,
      experience,
      goal,
      interests,
      createdAt,
      updatedAt,
    ];
  }
}
