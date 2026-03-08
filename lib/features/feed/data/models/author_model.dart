import 'package:aspira/features/feed/domain/entities/author_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author_model.g.dart';

@JsonSerializable()
class AuthorModel extends AuthorEntity {
  const AuthorModel({super.firstName, super.lastName, super.profilePicture});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return _$AuthorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);

  @override
  AuthorModel copyWith({
    String? firstName,
    String? lastName,
    dynamic profilePicture,
  }) {
    return AuthorModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
