import 'package:flutter/material.dart';

class BottomLayout extends StatelessWidget {
  const BottomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: const Text("OK",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              ),
              const SizedBox(width: 8),
              const Text('Select', style: TextStyle(color: Colors.black)),
            ],
          ),
          const SizedBox(width: 40),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_upward,
                    color: Colors.black, size: 18),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_downward,
                    color: Colors.black, size: 18),
              ),
              const SizedBox(width: 8),
              const Text('Navigate', style: TextStyle(color: Colors.black)),
            ],
          ),
          const SizedBox(width: 40),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.clear, color: Colors.black, size: 18),
              ),
              const SizedBox(width: 8),
              const Text('Clear App', style: TextStyle(color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
