import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/services/api_service.dart';
import 'dio_provider.dart';
import 'external_providers.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.read(dioProvider);
  final baseUrl = ref.read(baseUrlProvider);
  return ApiService(dio, baseUrl: baseUrl);
});
