import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/profile_option_model/profile_option_model.dart';
import 'package:aspira/repositories/profile_option_repo/I_profile_option.dart';
import 'package:aspira/services/profile_option_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileOptionProvider = Provider(
  (ref) => ProfileOptionImpl(
    profileOptionService: ref.read(profileOptionServiceProvider),
  ),
);

class ProfileOptionImpl implements IProfileOption {
  final ProfileOptionService profileOptionService;
  ProfileOptionImpl({required this.profileOptionService});
  @override
  Result<ProfileOptionModel> fetchInterest() async {
    try {
      final response = await profileOptionService.fetchProfileOptions();
      final profileOption = ProfileOptionModel.fromJson(
        (response.data['payload']),
      );

      return Right(profileOption);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      rethrow;
      return Left(ServerFailure(e.toString()));
    }
  }
}
