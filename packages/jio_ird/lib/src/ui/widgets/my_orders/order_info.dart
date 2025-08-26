import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  final String orderNo;

  final String billDetails;

  final String toPay;

  const OrderInfo(
      {super.key,
      required this.orderNo,
      required this.billDetails,
      required this.toPay});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order No",
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 4),
            Text(
              orderNo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        // Divider
        const SizedBox(width: 24),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey.shade400,
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bill details",
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 4),
            Text(
              billDetails,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        const SizedBox(width: 24),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey.shade400,
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "To Pay",
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 4),
            Text(
              toPay,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}
