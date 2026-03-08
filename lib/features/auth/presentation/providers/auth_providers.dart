import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:aspira/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:aspira/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aspira/features/auth/domain/repositories/auth_repository.dart';
import 'package:aspira/features/auth/domain/usecases/get_google_id_token_usecase.dart';
import 'package:aspira/features/auth/domain/usecases/login_usecase.dart';
import 'package:aspira/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:aspira/features/auth/domain/usecases/register_usecase.dart';
import 'package:aspira/features/auth/domain/usecases/update_profile_usecase.dart';

// Data source providers
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(dioClient: ref.watch(dioClientProvider)),
);

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);

// Use case providers
final loginUseCaseProvider = Provider(
  (ref) => LoginUseCase(repository: ref.watch(authRepositoryProvider)),
);

final registerUseCaseProvider = Provider(
  (ref) => RegisterUseCase(repository: ref.watch(authRepositoryProvider)),
);

final loginWithGoogleUseCaseProvider = Provider(
  (ref) =>
      LoginWithGoogleUseCase(repository: ref.watch(authRepositoryProvider)),
);

final getGoogleIdTokenUseCaseProvider = Provider(
  (ref) =>
      GetGoogleIdTokenUseCase(repository: ref.watch(authRepositoryProvider)),
);

final updateProfileUseCaseProvider = Provider(
  (ref) => UpdateProfileUseCase(repository: ref.watch(authRepositoryProvider)),
);
