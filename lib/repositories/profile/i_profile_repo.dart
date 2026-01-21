import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/profile_model/profile_model.dart';

abstract class IProfileRepo {
  Result<ProfileModel> fetchUserProfile();
  Future<void> updateUserProfile(String userId, ProfileModel profileData);
}
