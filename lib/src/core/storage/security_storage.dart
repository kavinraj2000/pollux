import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityStorage {
  SecurityStorage();

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String accessToken) async {
    await storage.write(key: 'access_token', value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<void> deleteAccessToken() async {
    await storage.delete(key: 'access_token');
  }

  Future<void> saveRefershToken(String refershToken) async {
    await storage.write(key: 'refersh_token', value: refershToken);
  }

  Future<String?> getRefershToken() async {
    return await storage.read(key: 'refersh_token');
  }
}
