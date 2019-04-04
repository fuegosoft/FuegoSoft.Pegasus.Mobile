import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> persistToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    return await storage.delete(key: 'token');
  }

  Future<bool> hasToken() async {
    return await storage.read(key: 'token') != null;
  }
}
