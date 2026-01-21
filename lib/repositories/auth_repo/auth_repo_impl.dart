import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/user_model/user_model.dart';
import 'package:aspira/repositories/auth_repo/i_auth_repo.dart';
import 'package:aspira/services/auth_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepoImpl(authService: ref.read(authServiceProvider)),
);

class AuthRepoImpl implements IAuthRepo {
  final AuthService authService;

  AuthRepoImpl({required this.authService});
  @override
  Result<Tuple2<String, UserModel>> login({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final responsen = await authService.login(payload: payload);
      final data = responsen.data as Map<String, dynamic>;
      final user = UserModel.fromJson(data['payload']['user']);
      final token = data['payload']['token'];
      return Right(Tuple2(token, user));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<Tuple2<String, UserModel>> register({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final responsen = await authService.register(payload: payload);
      final data = responsen.data as Map<String, dynamic>;
      final user = UserModel.fromJson(data['payload']['user']);
      final token = data['payload']['token'];
      return Right(Tuple2(token, user));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<String> updateProfile({required Map<String, dynamic> payload}) async {
    try {
      await authService.updateProfile(payload: payload);
      return Right('Profile updated successfully');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
