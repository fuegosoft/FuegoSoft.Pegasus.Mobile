import 'dart:convert';

import 'package:fuegosoft_mobile/models/models.dart';
import 'package:fuegosoft_mobile/network/request.dart';
import 'package:meta/meta.dart';

class UserRepository {
  Future<Token> authenticate({
    @required String username,
    @required String password,
  }) async {
    var response = await performLogin(username, password);
    return new Token.fromJsonBody(jsonDecode(response.body));
  }

  Future<bool> create({
    @required String username,
    @required String password,
    @required String emailAddress,
    @required String contactNumber,
    @required String firstName,
    String middleName,
    @required String lastName,
    @required String gender,
    @required DateTime birthDate,
  }) async {
    var response = await performCreateUser(
        username,
        password,
        emailAddress,
        contactNumber,
        firstName,
        middleName,
        lastName,
        gender,
        birthDate.toString());
    return jsonDecode(response.body) as bool;
  }
}
