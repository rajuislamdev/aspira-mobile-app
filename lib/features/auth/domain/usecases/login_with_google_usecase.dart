import 'package:dartz/dartz.dart';
import 'package:aspira/core/type_def/type_def.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogleUseCase {
  final AuthRepository repository;

  LoginWithGoogleUseCase({required this.repository});

  Result<Tuple2<String, UserEntity>> call({required String idToken}) {
    return repository.loginWithGoogle(idToken: idToken);
  }
}
