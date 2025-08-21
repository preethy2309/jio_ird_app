import 'package:jio_ird/utils/constants.dart';

import '../data/models/dish_with_quantity.dart';
import '../data/models/order_request.dart';

OrderRequest createOrderRequestFromDishWithQuantity(
  List<DishWithQuantity> items,
) {
  List<OrderDish> orderDishes = items.map((item) {
    return OrderDish(
      id: item.dish.id.toString(),
      quantity: item.quantity.toString(),
      cooking_request: item.cookingRequest.toString(),
      status: "submitted",
    );
  }).toList();

  return OrderRequest(
    dish_details: orderDishes,
    guest_id: kPropertyId,
    guest_name: "Guest",
    room_no: kRoomNo,
    serial_Num: kSerialNumber,
  );
}
