///contain getter for all api url and Header and parameters
class ApiUrl {
  static const String _root = 'https://fakestoreapi.com/';
  // static const String _root = 'https://www.autocar.com/api/client/';

  static Uri get products => Uri.parse(_root + 'products');
  static Uri get login => Uri.parse(_root + 'clientLogin');

  static Map<String, String> getHeader({required String token}) {
    return <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}

///This class contain keys used in api reqest
class ApiParameterKey {
  static String id = 'id';
  static String title = 'title';
  static String brand = 'brand';
  static String price = 'price';
  static String description = 'description';
  static String image = 'image';
}
