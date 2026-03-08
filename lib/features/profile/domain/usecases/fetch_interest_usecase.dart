import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/profile/data/models/profile_option_model/profile_option_model.dart';

import '../repositories/i_profile_repo.dart';

class FetchInterestUseCase {
  final IProfileRepo repository;

  FetchInterestUseCase({required this.repository});

  Result<ProfileOptionModel> call() {
    return repository.fetchInterest();
  }
}
