import 'package:dartz/dartz.dart';
import 'package:aspira/core/type_def/type_def.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Result<Tuple2<String, UserEntity>> call({
    required Map<String, dynamic> payload,
  }) {
    return repository.register(payload: payload);
  }
}
