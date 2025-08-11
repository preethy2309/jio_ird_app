import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/my_orders/status_connector.dart';
import 'package:jio_ird/ui/widgets/my_orders/status_step.dart';

class OrderCard extends StatelessWidget {
  final String dishName;
  final int qty;
  final String price;
  final String status;
  final bool isSelected;

  const OrderCard({
    super.key,
    required this.dishName,
    required this.qty,
    required this.price,
    required this.status,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Dish row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dishName,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Qty. $qty   ₹ $price",
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Status row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color:
                  isSelected ? Colors.grey.shade200 : const Color(0xFF111111),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatusStep(
                  icon: Icons.room_service,
                  label: "Order Placed",
                  active: true,
                  isSelected: isSelected,
                ),
                StatusConnector(isSelected: isSelected),
                StatusStep(
                  icon: Icons.check_circle_outline,
                  label: "Accepted",
                  isSelected: isSelected,
                ),
                StatusConnector(isSelected: isSelected),
                StatusStep(
                  icon: Icons.restaurant_menu,
                  label: "Preparing",
                  isSelected: isSelected,
                ),
                StatusConnector(isSelected: isSelected),
                StatusStep(
                  icon: Icons.delivery_dining,
                  label: "Served",
                  isSelected: isSelected,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
