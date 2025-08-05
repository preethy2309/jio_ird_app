import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/local_json_loader.dart';
import '../data/datasources/remote_api_client.dart';
import '../data/models/food_item.dart';
import '../data/repositories/food_repository.dart';
import '../data/repositories/food_repositoty_impl.dart';

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  final dio = Dio();
  final client = RemoteApiClient(dio);
  final loader = LocalJsonLoader();
  return FoodRepositoryImpl(client, loader);
});

final mealsProvider = FutureProvider.autoDispose<List<FoodItem>>((ref) async {
  final repo = ref.watch(foodRepositoryProvider);
  return repo.fetchMeals("RDTSBHF00004205", "12345");
});
