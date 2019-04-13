import 'dart:async';
import 'package:fuegosoft_mobile/models/models.dart';
import 'package:fuegosoft_mobile/utils/utils.dart';
import 'package:fuegosoft_mobile/repository/repository.dart';

class UserBloc implements BlocBase {
  User _user;

  UserRepository userRepository = UserRepository();
  SecureStorage storage = SecureStorage();

  StreamController<User> _userStreamController = StreamController<User>();
  Sink<User> get userSink => _userStreamController.sink;

  StreamController<bool> _successStreamController = StreamController<bool>();
  Sink<bool> get successSink => _successStreamController.sink;
  Stream<bool> get successStream => _successStreamController.stream;

  UserBloc() {
    _userStreamController.stream.listen(_performCreateUserAndGetResult);
  }

  @override
  void dispose() {
    _userStreamController.close();
    _successStreamController.close();
  }

  Future<void> _performCreateUserAndGetResult(User user) async {
    _user = user;
    if (_user != null) {
      var performCreate = await userRepository.create(
          username: user.username,
          password: user.password,
          emailAddress: user.emailAddress,
          contactNumber: user.contactNumber,
          firstName: user.firstName,
          middleName: user.middleName,
          lastName: user.lastName,
          gender: user.gender,
          birthDate: DateTime.parse(user.birthDate));
      successSink.add(performCreate);
    }
  }
}
