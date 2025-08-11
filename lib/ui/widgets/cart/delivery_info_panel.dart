import 'package:flutter/material.dart';

class DeliveryInfoPanel extends StatelessWidget {
  // final String deliveryTime;
  // final int guestCount;
  // final VoidCallback onIncreaseGuest;
  // final VoidCallback onDecreaseGuest;
  // final String allergies;
  // final String instructions;
  // final double totalAmount;
  // final VoidCallback onPlaceOrder;

  const DeliveryInfoPanel({
    super.key,
    // required this.deliveryTime,
    // required this.guestCount,
    // required this.onIncreaseGuest,
    // required this.onDecreaseGuest,
    // required this.allergies,
    // required this.instructions,
    // required this.totalAmount,
    // required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            icon: Icons.schedule,
            title: "Delivery Schedule",
            value: "10 PM",
            boldValue: true,
          ),
          const SizedBox(height: 10),
          _buildGuestCount(),
          const SizedBox(height: 10),
          _buildInfoRow(
            icon: Icons.warning_amber_rounded,
            title: "Allergies and Dietary Restrictions",
            value: "None",
            trailing: const Icon(Icons.chevron_right, color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            icon: Icons.chat_bubble_outline,
            title: "Specific Instructions",
            value: "None",
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {

              },
              child: const Text(
                "Place order - Rs. ${1100}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool boldValue = false,
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.white70),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            if (trailing != null) ...[
              const Spacer(),
              trailing,
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestCount() {
    return Row(
      children: [
        const Icon(Icons.person, size: 18, color: Colors.white70),
        const SizedBox(width: 8),
        const Text(
          "Guest in the room",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _buildQtyButton(Icons.add),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                 "1",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              _buildQtyButton(Icons.remove),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQtyButton(IconData icon) {
    return InkWell(
      onTap: () => {},
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 16),
      ),
    );
  }
}
