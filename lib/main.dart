import 'package:flutter/material.dart';
import 'package:jio_ird/jio_ird.dart';

void main() {
  runApp(const MyDemoApp());
}

class MyDemoApp extends StatelessWidget {
  const MyDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JioIRDScreen(
        focusTheme: const FocusTheme(
          focusedColor: Colors.orange,
          unfocusedColor: Colors.black,
          focusedTextColor: Colors.white,
          unfocusedTextColor: Colors.grey,
        ),
        accessToken: "XYZ123",
        serialNumber: "SN1234",
        guestInfo: const GuestInfo(
            roomNo: "roomNo",
            propertyId: "propertyId",
            guestName: "guestName",
            guestId: "guestId"),
        menuTitle: "In-Room Dining",
        onSocketEvent: (event, data) {
          debugPrint("Socket event: $event $data");
        },
      ),
    );
  }
}
