class APiUtl {
  //local url
  static const String MAIN_API_URL = 'http://44.239.196.64/api/';

  static const String AUTH_LOGIN = MAIN_API_URL + 'auth/login';
  static const String AUTH_REGISTER = MAIN_API_URL + 'auth/register';
  static const String PRODUCTS = MAIN_API_URL + 'products';
  static const String COUNTRIES = MAIN_API_URL + 'countries';
  static const String TAGS = MAIN_API_URL + 'tags';

  static String CITIES(int id) {
    return MAIN_API_URL  + 'countries/' + id.toString() + '/cities';
  }

  static const String CATEGORIES = MAIN_API_URL + 'categories';

  static String STATES(int id) {
    return MAIN_API_URL  + 'countries/' + id.toString() + '/states';
  }
}
