import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        //TODO take from external_provider
        final token = loadAuthToken();
        options.headers['Authorization'] = token;
        print("Headers: ${options.headers}");
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        final requestKey = error.requestOptions.uri.toString();
        retryCounts[requestKey] = (retryCounts[requestKey] ?? 0);

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

loadAuthToken() {
  const String kEncryptionIV = "5b5bc6c117391111";
  const String kEncryptionKey = "4db779e269dc587dd171516a86a62913";
  const String kSerialNum = "RDTSBKF00136359";
  var currentTime = DateTime.now().millisecondsSinceEpoch;

  String data = "{\"serial_num\":\"$kSerialNum\",\"time\":\"$currentTime\"}";

  final key = encrypt.Key.fromUtf8(kEncryptionKey);
  final iv = encrypt.IV.fromUtf8(kEncryptionIV);

  final encrypter = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
  );

  final encrypted = encrypter.encrypt(data, iv: iv);

  return encrypted.base64;
}
