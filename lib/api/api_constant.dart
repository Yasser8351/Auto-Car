///contain getter for all api url and Header and parameters
class ApiUrl {
  //static const String _root = 'https://fakestoreapi.com/';
  static const String _root = 'http://207.180.223.113:8975/api/v1/';

  /// production parameters
  static String get getAllOffer =>
      'http://207.180.223.113:8975/api/v1/Offer/MGetAll?';
  //static String get getAllOffer => _root + 'Offer/GetAll?';
  // static Uri get getAllOffer =>
  //     Uri.parse(_root + 'Offer/GetAll?PageNumber=1&PageSize=10');
  static Uri get getOfferDetails =>
      Uri.parse(_root + 'Offer/MGetOfferDetails?bid=');
  static Uri get getAllBrand => Uri.parse(_root + 'Brand/GetAll');
  static Uri get getAllCateory => Uri.parse(_root + 'Cartype/GetAll');

  /// Testing parameters
  static Uri get products => Uri.parse(_root + 'products');
  static Uri get login => Uri.parse(_root + 'clientLogin');

  static Map<String, String> getHeader() {
    return <String, String>{
      "content-type": "application/json",
      "accept": "application/json",
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
