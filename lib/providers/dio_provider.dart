import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/auth_encryption.dart';
import 'token_storage_provider.dart';

final tokenProvider = FutureProvider<String>((ref) async {
  final storage = ref.read(tokenStorageProvider);
  final savedToken = await storage.getToken();
  final expiry = await storage.getExpiry();

  // Check if saved token is still valid
  if (savedToken != null &&
      expiry != null &&
      DateTime.now().isBefore(expiry)) {
    return savedToken;
  }

  // Otherwise generate a new one
  final auth = AuthEncryption();
  final newToken = await auth.getAuthToken();

  // Save with 1hr expiry
  final expiryTime = DateTime.now().add(const Duration(minutes: 55));
  await storage.saveToken(newToken, expiryTime);

  return newToken;
});

/// Dio Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseHeader: false,
    responseBody: true,
    error: true,
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await ref.read(tokenProvider.future);
        options.headers['Authorization'] = token;
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401 ||
            error.response?.data.toString().contains("Token has been expired") == true) {
          final storage = ref.read(tokenStorageProvider);
          await storage.clearToken();
          ref.invalidate(tokenProvider);

          try {
            final newToken = await ref.read(tokenProvider.future);
            final response = await dio.fetch(
              error.requestOptions.copyWith(
                headers: {
                  ...error.requestOptions.headers,
                  'Authorization': newToken,
                },
              ),
            );
            return handler.resolve(response);
          } catch (_) {
            return handler.reject(error);
          }
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
});
