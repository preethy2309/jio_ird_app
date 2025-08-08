import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/food_item.dart';
import 'api_service_provider.dart';
import 'token_provider.dart';

final foodListProvider = FutureProvider<List<FoodItem>>((ref) async {
  final token = await ref.watch(tokenProvider.future);
  final api = ref.read(apiServiceProvider);

  return api.getFoodDetails(
    'RDTSBHF00004205', // serial_num
    '1234', // property_id
  );
});
