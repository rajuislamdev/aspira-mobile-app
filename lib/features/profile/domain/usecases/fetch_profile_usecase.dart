import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/profile/data/models/profile_model/profile_model.dart';

import '../repositories/i_profile_repo.dart';

class FetchProfileUseCase {
  final IProfileRepo repository;

  FetchProfileUseCase({required this.repository});

  Result<ProfileModel> call() {
    return repository.fetchUserProfile();
  }
}
