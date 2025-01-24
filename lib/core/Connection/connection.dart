import 'package:flutter_dotenv/flutter_dotenv.dart';

class Conn {
  static String baseLocalUrl = dotenv.env['BASE_LOCAL_URL'] ?? 'default_local_url';
  static String baseUrl = dotenv.env['BASE_URL'] ?? 'default_base_url';
  static String baseApiCheck = dotenv.env['BASE_API_CHECK'] ?? 'default_api_check';
  static String baseCartUrl = dotenv.env['BASE_CART_URL'] ?? 'default_api_check';
}
