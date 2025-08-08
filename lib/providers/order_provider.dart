import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/order_request.dart';
import '../data/models/order_status.dart';
import 'api_service_provider.dart';
import 'token_provider.dart';

final createOrderProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, OrderRequest>((ref, orderRequest) async {
  final token = await ref.watch(tokenProvider.future);
  final api = ref.read(apiServiceProvider);

  return await api.createOrder(orderRequest);
});

// final orderStatusProvider =
//     FutureProvider.family<List<OrderStatusResponse>, String>(
//         (ref, guestId) async {
//   final token = await ref.watch(tokenProvider.future);
//   final api = ref.read(apiServiceProvider);
//
//   return api.getOrderStatus(
//     guestId,
//     'RDTSBHF00004205', // serial_num
//   );
// });
