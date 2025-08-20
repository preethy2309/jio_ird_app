import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _tokenKey = 'auth_token';
  static const _expiryKey = 'auth_token_expiry';

  Future<void> saveToken(String token, DateTime expiry) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_expiryKey, expiry.toIso8601String());
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<DateTime?> getExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryStr = prefs.getString(_expiryKey);
    return expiryStr != null ? DateTime.tryParse(expiryStr) : null;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_expiryKey);
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());
