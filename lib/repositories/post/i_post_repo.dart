import 'package:aspira/core/type_def/type_def.dart';

abstract class IPostRepo {
  Result<String> createPost({required Map<String, dynamic> payload});
}
