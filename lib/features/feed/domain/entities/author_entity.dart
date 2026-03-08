import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final dynamic profilePicture;

  const AuthorEntity({
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  AuthorEntity copyWith({
    String? firstName,
    String? lastName,
    dynamic profilePicture,
  }) {
    return AuthorEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, profilePicture];
}
