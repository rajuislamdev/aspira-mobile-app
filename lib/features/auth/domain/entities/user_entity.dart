class UserEntity {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? profilePictureUrl;
  final String? bio;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? location;
  final String? website;
  final List<String>? interests;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.profilePictureUrl,
    this.bio,
    this.dateOfBirth,
    this.gender,
    this.location,
    this.website,
    this.interests,
    this.createdAt,
    this.updatedAt,
  });
}
