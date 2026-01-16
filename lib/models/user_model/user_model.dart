import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? experience;
  final String? dailyGoal;

  const UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.experience,
    this.dailyGoal,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? experience,
    String? dailyGoal,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      experience: experience ?? this.experience,
      dailyGoal: dailyGoal ?? this.dailyGoal,
    );
  }

  @override
  List<Object?> get props {
    return [id, email, firstName, lastName, experience, dailyGoal];
  }
}
