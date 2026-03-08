import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/profile/data/models/profile_model/profile_model.dart';
import 'package:aspira/features/profile/data/models/profile_option_model/profile_option_model.dart';

abstract class IProfileRepo {
  Result<ProfileModel> fetchUserProfile();
  Future<void> updateUserProfile(String userId, ProfileModel profileData);
  Result<ProfileOptionModel> fetchInterest();
}
