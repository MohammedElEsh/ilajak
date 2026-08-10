class ApiEndpoints {
  static const String baseUrl =
      'https://fifty-partly-blighted.ngrok-free.dev/api';
  static const String login = '/login';
  static const String refresh = '/auth/refresh-token';
  static const String registerPatient = '/register';
  static const String registerDoctor = '/doctor/register';
  static const String profile = '/auth/profile';
  static const String checkEmailAvailability = '/users/is-available';
  static const String categories = '/categories';
  static const String products = '/products';
  // Profile
  static const String profileOverView = '/profile';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';
}
