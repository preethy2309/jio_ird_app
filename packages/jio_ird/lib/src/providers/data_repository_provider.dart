import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/api_service.dart';
import '../repository/data_repository.dart';
import 'dio_provider.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final dataRepositoryProvider = Provider<DataRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  return DataRepository(api);
});
