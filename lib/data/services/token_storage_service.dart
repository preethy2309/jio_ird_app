import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static const _tokenKey = 'auth_token';
  static const _timestampKey = 'token_timestamp';
  static const _expiryDuration = Duration(hours: 1); // or as defined by backend

  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(
      key: _timestampKey,
      value: DateTime.now().toIso8601String(),
    );
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    final timestampStr = await _storage.read(key: _timestampKey);
    if (token == null || timestampStr == null) return null;

    final timestamp = DateTime.tryParse(timestampStr);
    if (timestamp == null) return null;

    final isExpired = DateTime.now().isAfter(timestamp.add(_expiryDuration));
    if (isExpired) {
      await clearToken();
      return null;
    }

    return token;
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _timestampKey);
  }
}

