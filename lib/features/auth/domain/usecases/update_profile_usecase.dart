import 'package:aspira/core/type_def/type_def.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase({required this.repository});

  Result<String> call({required Map<String, dynamic> payload}) {
    return repository.updateProfile(payload: payload);
  }
}
