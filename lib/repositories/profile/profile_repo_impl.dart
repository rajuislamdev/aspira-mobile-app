import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/profile_model/profile_model.dart';
import 'package:aspira/repositories/profile/i_profile_repo.dart';
import 'package:aspira/services/profile_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepoProvider = Provider(
  (ref) => ProfileRepoImpl(profileService: ref.read(profileServiceProvider)),
);

class ProfileRepoImpl extends IProfileRepo {
  final ProfileService profileService;
  ProfileRepoImpl({required this.profileService});
  @override
  Result<ProfileModel> fetchUserProfile() async {
    try {
      final response = await profileService.fetchProfile();
      final data = response.data['payload'];
      final profile = ProfileModel.fromJson(data);
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      rethrow;
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> updateUserProfile(String userId, ProfileModel profileData) {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }
}
