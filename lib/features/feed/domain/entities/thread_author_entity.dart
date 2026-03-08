import 'package:equatable/equatable.dart';

class ThreadAuthorEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final dynamic profilePicture;

  const ThreadAuthorEntity({
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  ThreadAuthorEntity copyWith({
    String? firstName,
    String? lastName,
    dynamic profilePicture,
  }) {
    return ThreadAuthorEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, profilePicture];
}
