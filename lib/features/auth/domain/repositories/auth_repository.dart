import 'package:dartz/dartz.dart';
import 'package:aspira/core/type_def/type_def.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Result<Tuple2<String, UserEntity>> register({
    required Map<String, dynamic> payload,
  });

  Result<Tuple2<String, UserEntity>> login({
    required Map<String, dynamic> payload,
  });

  Result<String> updateProfile({required Map<String, dynamic> payload});

  Result<String?> getGoogleIdToken();

  Result<Tuple2<String, UserEntity>> loginWithGoogle({required String idToken});
}
