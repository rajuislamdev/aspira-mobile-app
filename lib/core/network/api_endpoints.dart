import 'package:aspira/core/config/environment.dart';

class ApiEndpoints {
  static const String baseUrl = EnvironmentConfig.apiBaseUrl;
  static final String register = '$baseUrl/auth/register';
  static final String login = '$baseUrl/auth/loginOrRegister';
  static final String loginWithGoogle = '$baseUrl/auth/google';
  static final String fetchProfileOptions = '$baseUrl/users/profile-options';
  static final String user = '$baseUrl/users/me';

  // Post
  static final String posts = '$baseUrl/posts';
  static final String reactPost = '$baseUrl/posts/:postId/reaction';
  static final String fetchPostsThread = '$baseUrl/posts/:postId/thread';
  static final String commentPost = '$baseUrl/posts/:postId/reply';
  static final String bookmarkPost = '$baseUrl/posts/:postId/bookmark';
  static final String fetchBookmarkedPosts = '$baseUrl/posts/bookmarks';
}
