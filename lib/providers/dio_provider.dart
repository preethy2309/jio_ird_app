import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'token_provider.dart';
import 'token_storage_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await ref.read(tokenProvider.future);
        options.headers['Authorization'] = token;
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final storage = ref.read(tokenStorageProvider);
          await storage.clearToken(); // Remove old token
          ref.invalidate(tokenProvider); // Force refresh

          try {
            final newToken = await ref.read(tokenProvider.future);
            final clonedRequest = error.requestOptions;
            clonedRequest.headers['Authorization'] = newToken;

            final response = await dio.fetch(clonedRequest);
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
