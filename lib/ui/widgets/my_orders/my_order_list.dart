import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/my_orders/order_info.dart';

class MyOrderList extends StatelessWidget {
  const MyOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _orderTile(
          orderNo: '005053',
          billDetails: '4 Items',
          toPay: '₹ 700',
          isActive: true,
          buttonText: 'Track order',
        ),
        const SizedBox(height: 12),
        _orderTile(
          orderNo: '005053',
          billDetails: '2 Items',
          toPay: '₹ 200',
          isActive: false,
          buttonText: 'Track Order',
        ),
      ],
    );
  }

  Widget _orderTile({
    required String orderNo,
    required String billDetails,
    required String toPay,
    bool isActive = false,
    required String buttonText,
    bool isButton = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.amber : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 100),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side details
          OrderInfo(orderNo: orderNo, billDetails: billDetails, toPay: toPay),

          // Right side button
          isButton
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(buttonText),
                )
              : Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }
}
