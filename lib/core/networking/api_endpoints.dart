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
  static const String doctors = '/doctors';
  static String singleDoctor(int id) {
    return '/doctors/$id';
  }
  static String availableTimeSlots(int doctorId, DateTime date) {
    final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return '/doctors/$doctorId/available-slots?date=$formattedDate';
  }
  static const String bookAppointment = '/appointments';
  // Profile
  static const String profileOverView = '/profile';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';
  static const String logout = '/logout';
}
