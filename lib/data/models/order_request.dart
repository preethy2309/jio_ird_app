class OrderRequest {
  final List<OrderDish> dish_details;
  final String guest_id;
  final String guest_name;
  final String room_no;
  final String serial_Num;

  OrderRequest({
    required this.dish_details,
    required this.guest_id,
    required this.guest_name,
    required this.room_no,
    required this.serial_Num,
  });

  Map<String, dynamic> toJson() {
    return {
      'dish_details': dish_details.map((d) => d.toJson()).toList(),
      'guest_id': guest_id,
      'guest_name': guest_name,
      'room_no': room_no,
      'serial_Num': serial_Num,
    };
  }
}

class OrderDish {
  final String id;
  final String quantity;
  final String cooking_request;
  final String status;

  OrderDish({
    required this.id,
    required this.quantity,
    required this.cooking_request,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'cooking_request': cooking_request,
      'status': status,
    };
  }
}
