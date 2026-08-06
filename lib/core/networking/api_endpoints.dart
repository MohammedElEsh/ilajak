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
   
}
