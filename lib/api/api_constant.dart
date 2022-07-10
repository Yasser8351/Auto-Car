///contain getter for all api url and Header and parameters
class ApiUrl {
  static const String _root = 'https://wasel.gulfsmo.net/api/client/';
  static const String _googleApiKey = 'AIzaSyClrFqfOqOGTSGWpiZby6POa-AEFjGmJoM';
  static const String _rootGoogle =
      'https://maps.googleapis.com/maps/api/geocode/json?';

  static Uri get login => Uri.parse(_root + 'clientLogin');
  static Uri get register => Uri.parse(_root + 'clientRegister');
  static Uri get updateUser => Uri.parse(_root + 'updateClientAccount');
  static Uri get logout => Uri.parse(_root + 'clientLogout');
  static Uri get addFuelOrder => Uri.parse(_root + 'addfuelOrder');
  static Uri get addFuelShippingOrder =>
      Uri.parse(_root + 'fuleShiping/addFuleShiping');
  static Uri get addShippingOrder => Uri.parse(_root + 'AddGoodShiping');
  static Uri get getClientOrders => Uri.parse(_root + 'getClientOrders');
  static Uri get getHistoryOrders =>
      Uri.parse(_root + 'getClientHistoryOrders');
  static Uri get cancelOrder => Uri.parse(_root + 'cancelOrder');
  static Uri get getIFueShipingInqueriesURL =>
      Uri.parse(_root + 'fuleShiping/getIFueShipingInqueries');
  static Uri get getAllVehicles => Uri.parse(_root + 'getAllVehicles');

  static Uri get getPrices => Uri.parse(_root + 'getPrices');
  static Map<String, String> getHeader({required String token}) {
    return <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}

///This class contain keys used in api reqest
class ApiParameterKey {
  static String phone = 'phone';
  static String mobileID = 'device_name';
  static String name = 'fullname';
  static String deliveryType = 'delivery_type';
  static String fuelType = 'fuel_type';
}
