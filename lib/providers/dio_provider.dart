import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/auth_encryption.dart';
import 'token_storage_provider.dart';

final tokenProvider = FutureProvider<String>((ref) async {
  final storage = ref.read(tokenStorageProvider);
  final savedToken = await storage.getToken();
  final expiry = await storage.getExpiry();

  if (savedToken != null && expiry != null && DateTime.now().isBefore(expiry)) {
    return savedToken;
  }

  final auth = AuthEncryption();
  final newToken = await auth.getAuthToken();
  final expiryTime = DateTime.now().add(const Duration(minutes: 55));
  await storage.saveToken(newToken, expiryTime);

  return newToken;
});

Completer<String>? _refreshCompleter;

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

  final Map<String, int> retryCounts = {};

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await ref.read(tokenProvider.future);
        options.headers['Authorization'] = token;
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        final requestKey = error.requestOptions.uri.toString();
        retryCounts[requestKey] = (retryCounts[requestKey] ?? 0);

        if (error.response?.statusCode == 401 ||
            error.response?.data
                    .toString()
                    .contains("Token has been expired") ==
                true) {
          final storage = ref.read(tokenStorageProvider);

          if (_refreshCompleter == null) {
            _refreshCompleter = Completer<String>();
            try {
              await storage.clearToken();
              ref.invalidate(tokenProvider);

              final newToken = await ref.read(tokenProvider.future);
              _refreshCompleter!.complete(newToken);
            } catch (e) {
              _refreshCompleter!.completeError(e);
            } finally {
              final tmp = _refreshCompleter;
              _refreshCompleter = null;
              await tmp?.future;
            }
          }

          try {
            final newToken = await _refreshCompleter!.future;
            final response = await dio.fetch(
              error.requestOptions.copyWith(
                headers: {
                  ...error.requestOptions.headers,
                  'Authorization': newToken,
                },
              ),
            );
            return handler.resolve(response);
          } catch (e) {
            return handler.reject(error);
          }
        }

        if (retryCounts[requestKey]! < 5 &&
            (error.type == DioExceptionType.connectionError ||
                error.type == DioExceptionType.receiveTimeout ||
                error.type == DioExceptionType.sendTimeout ||
                (error.response?.statusCode ?? 500) >= 500)) {
          retryCounts[requestKey] = retryCounts[requestKey]! + 1;
          try {
            final response = await dio.fetch(error.requestOptions);
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
