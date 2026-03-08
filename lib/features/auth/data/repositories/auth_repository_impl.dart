import 'package:aspira/core/errors/exceptions.dart';
import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:aspira/features/auth/data/models/user_response_model.dart';
import 'package:aspira/features/auth/domain/entities/user_entity.dart';
import 'package:aspira/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Result<Tuple2<String, UserEntity>> login({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await remoteDataSource.login(payload: payload);
      final data = response.data as Map<String, dynamic>;
      final user = UserResponseModel.fromJson(data['payload']['user']);
      final token = data['payload']['token'] as String;
      return Right(Tuple2(token, user));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<Tuple2<String, UserEntity>> register({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await remoteDataSource.register(payload: payload);
      final data = response.data as Map<String, dynamic>;
      final user = UserResponseModel.fromJson(data['payload']['user']);
      final token = data['payload']['token'] as String;
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
      await remoteDataSource.updateProfile(payload: payload);
      return const Right('Profile updated successfully');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<String?> getGoogleIdToken() async {
    try {
      final token = await remoteDataSource.getGoogleIdToken();
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Result<Tuple2<String, UserEntity>> loginWithGoogle({
    required String idToken,
  }) async {
    try {
      final response = await remoteDataSource.loginWithGoogle(idToken: idToken);
      final data = response.data as Map<String, dynamic>;
      final user = UserResponseModel.fromJson(data['payload']['user']);
      final token = data['payload']['token'] as String;
      return Right(Tuple2(token, user));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
