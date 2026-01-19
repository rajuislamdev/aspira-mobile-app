import 'package:aspira/core/type_def/type_def.dart';
import 'package:aspira/models/profile_option_model/profile_option_model.dart';

abstract class IProfileOption {
  Result<ProfileOptionModel> fetchInterest();
}
