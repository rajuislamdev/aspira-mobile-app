import 'package:aspira/core/network/dio_client.dart';
import 'package:aspira/features/feed/data/datasources/post_remote_data_source.dart';
import 'package:aspira/features/feed/data/repositories/post_repository_impl.dart';
import 'package:aspira/features/feed/domain/repositories/post_repository.dart';
import 'package:aspira/features/feed/domain/usecases/add_comment_usecase.dart';
import 'package:aspira/features/feed/domain/usecases/bookmark_post_usecase.dart';
import 'package:aspira/features/feed/domain/usecases/create_post_usecase.dart';
import 'package:aspira/features/feed/domain/usecases/fetch_bookmarked_posts_usecase.dart';
import 'package:aspira/features/feed/domain/usecases/fetch_posts_usecase.dart';
import 'package:aspira/features/feed/domain/usecases/fetch_threads_usecase.dart';
import 'package:aspira/features/feed/domain/usecases/react_post_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Data Source Provider
final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  return PostRemoteDataSourceImpl(
    dioClient: ref.read(dioClientProvider),
  );
});

/// Repository Provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(
    remoteDataSource: ref.read(postRemoteDataSourceProvider),
  );
});

/// Use Case Providers
final createPostUseCaseProvider = Provider<CreatePostUseCase>((ref) {
  return CreatePostUseCase(ref.read(postRepositoryProvider));
});

final fetchPostsUseCaseProvider = Provider<FetchPostsUseCase>((ref) {
  return FetchPostsUseCase(ref.read(postRepositoryProvider));
});

final fetchBookmarkedPostsUseCaseProvider = Provider<FetchBookmarkedPostsUseCase>((ref) {
  return FetchBookmarkedPostsUseCase(ref.read(postRepositoryProvider));
});

final reactPostUseCaseProvider = Provider<ReactPostUseCase>((ref) {
  return ReactPostUseCase(ref.read(postRepositoryProvider));
});

final bookmarkPostUseCaseProvider = Provider<BookmarkPostUseCase>((ref) {
  return BookmarkPostUseCase(ref.read(postRepositoryProvider));
});

final fetchThreadsUseCaseProvider = Provider<FetchThreadsUseCase>((ref) {
  return FetchThreadsUseCase(ref.read(postRepositoryProvider));
});

final addCommentUseCaseProvider = Provider<AddCommentUseCase>((ref) {
  return AddCommentUseCase(ref.read(postRepositoryProvider));
});
