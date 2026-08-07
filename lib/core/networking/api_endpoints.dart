class ApiEndpoints {
  static const String baseUrl = 'https://ilajak-backend-production.up.railway.app/api';
  static const String login = '/login';
  static const String refresh = '/auth/refresh-token';
  static const String register = '/users';
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
}
