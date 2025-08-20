// Function to create an OrderRequest
import '../data/models/dish_with_quantity.dart';
import '../data/models/order_request.dart';

OrderRequest createOrderRequestFromDishWithQuantity(
    List<DishWithQuantity> items,
    String guestId,
    String guestName,
    String roomNo,
    String serialNum) {
  List<OrderDish> orderDishes = items.map((item) {
    return OrderDish(
      id: item.dish.id,
      quantity: item.quantity.toString(),
      cooking_request: item.dish.cooking_request.toString(),
      status: "submitted",
    );
  }).toList();

  return OrderRequest(
    dish_details: orderDishes,
    guest_id: guestId,
    guest_name: guestName,
    room_no: roomNo,
    serial_Num: serialNum,
  );
}
