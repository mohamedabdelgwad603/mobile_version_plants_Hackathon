String baseUrl = 'https://lavie.orangedigitalcenteregypt.com';

class AuthEndPoints {
  static String path = '/api/v1/auth';
  static String login = '$path/signin';
  static String register = '$path/signup';
  static String google = '$path/google';
  static String face = '$path/facebook';
  static String forgetPassword = '$path/forget-password';
}
