import 'package:aspira/core/type_def/type_def.dart';
import '../repositories/auth_repository.dart';

class GetGoogleIdTokenUseCase {
  final AuthRepository repository;

  GetGoogleIdTokenUseCase({required this.repository});

  Result<String?> call() {
    return repository.getGoogleIdToken();
  }
}
