class Endpoint {
  // static const String baseUrlApi = "https://serverproxy.mediatamasolo.com/api/";
  // static const String baseUrlPython =
  //     "https://serverproxypython.mediatamasolo.com/api/";
  static const String baseUrlApi = "http://192.168.1.3:8000";
  static const String baseUrlPython = "http://192.168.1.3:8001";

  // Authenticated
  static const String register = "${baseUrlApi}/api/auth/registrasi";
  static const String login = "${baseUrlApi}/api/auth/login";
  static const String logout = "${baseUrlApi}/api/auth/logout";
  static const String verifyOtp = "${baseUrlApi}/api/auth/verify";
  static const String resendOtp = "${baseUrlApi}/api/auth/resend-otp";
  static const String resetPassword = "${baseUrlApi}/api/auth/forgot-password";

  // Foto
  static const String foto = "${baseUrlApi}/api/foto";

  // Komentar
  static const String komentar = "${baseUrlApi}/api/komentar";

  // Like
  static const String like = "${baseUrlApi}/api/like";

  // Album
  static const String album = "${baseUrlApi}/api/album";
}
