// This file is kept for backward compatibility
// The auth repository implementation has moved to the auth module following clean architecture
// For new code, use the provider from:
// import 'package:aspira/features/auth/presentation/providers/auth_providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aspira/core/network/dio_client.dart';
import 'package:aspira/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:aspira/features/auth/data/repositories/auth_repository_impl.dart';

// Provide the auth repository for backward compatibility
final authRepoProvider = Provider<AuthRepositoryImpl>(
  (ref) => AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(
      dioClient: ref.read(dioClientProvider),
    ),
  ),
);
