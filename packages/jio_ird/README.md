# jio_ird

A Flutter package for integrating **JioHotel IRD (In-Room Dining)** APIs with prebuilt UI screens.  
This package helps you quickly set up **Menu, Cart, My Orders, and Order Tracking** screens in your
Flutter TV/OTT applications with D-pad/remote navigation support.

---

## ✨ Features

- Easy integration of Jio IRD APIs
- TV/OTT ready with full D-pad navigation
- Prebuilt screens:
    - Menu with categories, sub-categories & dishes
    - Cart with quantity and guest details
    - My Orders
    - Track Order
- Powered by Riverpod & Retrofit

---

## 📦 Getting Started

### 1. Add Dependency

In your `pubspec.yaml`, add:

```yaml
dependencies:
  jio_ird:
  path: packages/jio_ird
```

Run:

```bash
flutter pub get
```

---

### 2. Import the Package

```dart
import 'package:jio_ird/jio_ird.dart';
```

---

## Usage

You can directly use the **`JioIrdScreen`** widget to launch the In-Room Dining module.

```dart
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
          focusedColor: Colors.amber,
          unfocusedColor: Color(0xFF430B42),
          focusedTextColor: Color(0xFF430B42),
          unfocusedTextColor: Colors.amber,
        ),
        baseUrl: "kBaseUrl",
        accessToken: "YOUR_ACCESS_TOKEN",
        serialNumber: "DEVICE_SERIAL_NUMBER",
        guestInfo: const GuestInfo(
            roomNo: "YOUR_ROOM_NO",
            propertyId: "YOUR_PROPERTY_ID",
            guestName: "YOUR_GUEST_NAME",
            guestId: "YOUR_GUEST_ID"),
        menuTitle: "In-Room Dining",//NOT MANDATORY
        bottomBar: CustomBottomLayout(), //NOT MANDATORY
        onSocketEvent: (event, data) { //NOT MANDATORY
          debugPrint("Socket event: $event $data");
        },
      ),
    );
  }
}
```
