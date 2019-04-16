import 'dart:convert';

import 'package:http/http.dart' as http;
import 'url_request.dart';

Future<http.Response> performLogin(String username, String password) async {
  var body = json.encode({'username': username, 'password': password});
  var header = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  return await http.post(URLRequest.LOGIN, body: body, headers: header);
}

Future<http.Response> performCreateUser(
  String username,
  String password,
  String emailAddress,
  String contactNumber,
  String firstName,
  String middleName,
  String lastName,
  String gender,
  String birthDate,
) async {
  var body = json.encode({
    'username': username,
    'password': password,
    'emailAddress': emailAddress,
    'contactNumber': contactNumber,
    'firstName': firstName,
    'middleName': middleName,
    'lastName': lastName,
    'gender': gender,
    'birthDate': birthDate,
  });

  var header = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  return await http.post(URLRequest.REGISTER, body: body, headers: header);
}
