import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:aspira/features/profile/data/models/profile_model/profile_model.dart';
import 'package:aspira/features/profile/domain/repositories/i_profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>(
  (ref) => ProfileRemoteDataSourceImpl(dioClient: ref.read(dioClientProvider)),
);

final profileRepoProvider = Provider(
  (ref) => ProfileRepoImpl(
    profileRemoteDataSource: ref.read(profileRemoteDataSourceProvider),
  ),
);

class ProfileRepoImpl extends IProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepoImpl({required this.profileRemoteDataSource});
  @override
  Result<ProfileModel> fetchUserProfile() async {
    try {
      final response = await profileRemoteDataSource.fetchProfile();
      final data = response.data['payload'];
      final profile = ProfileModel.fromJson(data);
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> updateUserProfile(
    String userId,
    ProfileModel profileData,
  ) async {
    await profileRemoteDataSource.updateProfile(
      userId: userId,
      payload: profileData.toJson(),
    );
  }
}
