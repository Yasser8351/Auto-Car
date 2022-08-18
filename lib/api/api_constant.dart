///contain getter for all api url and Header and parameters
class ApiUrl {
  //static const String _root = 'https://fakestoreapi.com/';
  static const String _root = 'http://207.180.223.113:8975/api/v1/';

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImUxZGFjMDE4LWQ5YjUtNDI1NC1hZjdhLTRiNGFhMzg0MWY4YSIsIm5hbWVpZCI6ImUxZGFjMDE4LWQ5YjUtNDI1NC1hZjdhLTRiNGFhMzg0MWY4YSIsInN1YiI6Inlhc3NlcjgzNTFAZ21haWwuY29tIiwiZW1haWwiOiJ5YXNzZXI4MzUxQGdtYWlsLmNvbSIsImp0aSI6ImZmNThkYjkwLTk4NWEtNDM3Ni1iMzcxLTg2NTA2NjljNjVjZCIsIm5iZiI6MTY2MDgwNjU0NSwiZXhwIjoxNjYwODA3MTQ1LCJpYXQiOjE2NjA4MDY1NDV9.mad3vnwdgVl8D8DdzTdS9H2kf-8w_0e1rp-4OCGplXE";

  /// production parameters
  static String get getAllOffer =>
      'http://207.180.223.113:8975/api/v1/Offer/MGetAll?';
  static String get getOfferDetails => _root + 'Offer/MGetOfferDetails';
  static String get getOffersByCategory => _root + 'Offer/MGetOffersByCarType?';

  //http://207.180.223.113:8975/api/v1/Offer/MGetOffersByCarType?PageNumber=1&PageSize=10

  // static Uri get getAllOffer =>
  //     Uri.parse(_root + 'Offer/GetAll?PageNumber=1&PageSize=10');

  static Uri get getAllBrand => Uri.parse(_root + 'Brand/GetAll');
  static Uri get getAllCateory => Uri.parse(_root + 'Cartype/GetAll');

  /// Testing parameters
  static Uri get products => Uri.parse(_root + 'products');
  static Uri get login => Uri.parse(_root + 'clientLogin');

  static Map<String, String> getHeader() {
    return <String, String>{
      // 'Authorization': 'Bearer $token',
      // "content-type": "application/json",
      // "accept": "application/json",
      'accept': '*/*',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImUxZGFjMDE4LWQ5YjUtNDI1NC1hZjdhLTRiNGFhMzg0MWY4YSIsIm5hbWVpZCI6ImUxZGFjMDE4LWQ5YjUtNDI1NC1hZjdhLTRiNGFhMzg0MWY4YSIsInN1YiI6Inlhc3NlcjgzNTFAZ21haWwuY29tIiwiZW1haWwiOiJ5YXNzZXI4MzUxQGdtYWlsLmNvbSIsImp0aSI6ImZmNThkYjkwLTk4NWEtNDM3Ni1iMzcxLTg2NTA2NjljNjVjZCIsIm5iZiI6MTY2MDgwNjU0NSwiZXhwIjoxNjYwODA3MTQ1LCJpYXQiOjE2NjA4MDY1NDV9.mad3vnwdgVl8D8DdzTdS9H2kf-8w_0e1rp-4OCGplXE',
      'Content-Type': 'application/json'
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
