import 'dart:async';
import 'package:fuegosoft_mobile/models/models.dart';
import 'package:fuegosoft_mobile/utils/utils.dart';
import 'package:fuegosoft_mobile/repository/repository.dart';

class LoginBloc implements BlocBase {
  Token _token;
  Login _login;
  UserRepository _userRepository;
  SecureStorage storage = SecureStorage();

  // Stream to handle the token
  StreamController<Login> _loginController = StreamController<Login>();
  Sink<Login> get loginSink => _loginController.sink;

  StreamController<Token> _tokenController = StreamController<Token>();
  Sink<Token> get tokenSink => _tokenController.sink;
  Stream<Token> get tokenStream => _tokenController.stream;

  @override
  void dispose() {
    _loginController.close();
    _tokenController.close();
  }

  LoginBloc() {
    _loginController.stream.listen(_performLoginAndGetToken);
  }

  Future<void> _performLoginAndGetToken(Login login) async {
    _login = login;
    if (login.username.length > 4 && login.password.length > 7) {
      var performAuth = await _userRepository.authenticate(
          username: login.username, password: login.password);
      if (performAuth.token != '') {
        storage.persistToken(performAuth.token);
        tokenSink.add(performAuth);
      }
    }
  }
}
