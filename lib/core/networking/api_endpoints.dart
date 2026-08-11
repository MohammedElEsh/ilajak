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
  static const String bookAppointment = '/appointments';
  // Profile
  static const String profileOverView = '/profile';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';
  static const String logout = '/logout';
  static const String changePassword = '/user/change-password';

  // Doctor Profile
  static const String doctorProfile = '/doctor/profile';
  static const String doctorProfileAvatar = '/doctor/profile/avatar';

  // Appointments
  static const String appointments = '/appointments';
  static String appointmentStatus(int appointmentId) =>
      '/appointments/$appointmentId/status';

  // Medical Records
  static const String medicalRecords = '/medical-records';

  // Prescriptions
  static const String prescriptions = '/prescriptions';
}
