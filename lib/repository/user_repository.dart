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
}
