import 'package:http/http.dart' as http;
import 'url_request.dart';

Future<http.Response> performLogin(String username, String password) async {
  var body = {'username': username, 'password': password};
  return await http.post(URLRequest.LOGIN, body: body);
}
