import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author extends Equatable {
  final String? firstName;
  final String? lastName;
  final dynamic profilePicture;

  const Author({this.firstName, this.lastName, this.profilePicture});

  factory Author.fromJson(Map<String, dynamic> json) {
    return _$AuthorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  Author copyWith({
    String? firstName,
    String? lastName,
    dynamic profilePicture,
  }) {
    return Author(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, profilePicture];
}
