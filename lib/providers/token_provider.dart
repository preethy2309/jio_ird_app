import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/providers/token_storage_provider.dart';
import '../data/services/api_service.dart';


final tokenProvider = FutureProvider<String>((ref) async {
  final storage = ref.read(tokenStorageProvider);

  // 1. Try to get valid cached token
  final cachedToken = await storage.getToken();
  if (cachedToken != null) {
    return cachedToken;
  }

  // 2. If no valid token, request a new one
  final dio = Dio(BaseOptions(headers: {'Content-Type': 'application/json'}));
  final api = ApiService(dio);

  final response = await api.generateToken('RDTSBHF00004205'); // Serial num

  // 3. Save token securely with timestamp
  await storage.saveToken(response.result);

  return response.result;
});
