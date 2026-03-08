import 'package:aspira/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:aspira/features/profile/domain/usecases/fetch_profile_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider((ref) {
  return ref.read(profileRepoProvider);
});

final fetchProfileUseCaseProvider = Provider((ref) {
  return FetchProfileUseCase(repository: ref.read(profileRepositoryProvider));
});
