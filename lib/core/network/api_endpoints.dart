class ApiEndpoints {
  static final String baseUrl = 'http://192.168.0.170:5001/api';
  static final String register = '$baseUrl/auth/register';
  static final String login = '$baseUrl/auth/loginOrRegister';
  static final String loginWithGoogle = '$baseUrl/auth/google';
  static final String fetchProfileOptions = '$baseUrl/users/profile-options';
  static final String user = '$baseUrl/users/me';

  // Post
  static final String posts = '$baseUrl/posts';
  static final String reactPost = '$baseUrl/posts/:postId/reaction';
}
