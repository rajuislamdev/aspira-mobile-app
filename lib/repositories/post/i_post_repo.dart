// Backward compatibility file
// This file re-exports the PostRepository from the new location
// TODO: Update imports to use aspira/features/feed/domain/repositories/post_repository.dart

import 'package:aspira/features/feed/domain/repositories/post_repository.dart';

typedef IPostRepo = PostRepository;
