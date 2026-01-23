import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/user_model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepo {
  Result<Tuple2<String, UserModel>> register({required Map<String, dynamic> payload});
  Result<Tuple2<String, UserModel>> login({required Map<String, dynamic> payload});
  Result<String> updateProfile({required Map<String, dynamic> payload});
  Result<String?> getGoogleIdToken();
  Result<Tuple2<String, UserModel>> loginWithGoogle({required String idToken});
}
