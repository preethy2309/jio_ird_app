import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:jio_ird/jio_ird.dart';

void main() {
  runApp(const MyDemoApp());
}

const String kEncryptionIV = "5b5bc6c117391111";
const String kEncryptionKey = "4db779e269dc587dd171516a86a62913";
const String kSerialNumber = "RNOSBFJNX026030";
const String kRoomNo = "1010-Dipesh";
const String kPropertyId = "2186";
const String kGuestName = "Dipesh Jain";
const String kGuestId = "822";
const String kBaseUrl = "https://devices.cms.jio.com/jiohotels/";

class MyDemoApp extends StatelessWidget {
  const MyDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JioIRDScreen(
        focusTheme: const FocusTheme(
          focusedColor: Color(0xFF009523),
          unfocusedColor: Color(0xFFFFFFFF),
          focusedTextColor: Color(0xFFFFFFFF),
          unfocusedTextColor: Color(0xFF009523),
        ),
        baseUrl: kBaseUrl,
        accessToken: loadAuthToken(),
        serialNumber: kSerialNumber,
        guestInfo: const GuestInfo(
            roomNo: kRoomNo,
            propertyId: kPropertyId,
            guestName: kGuestName,
            guestId: kGuestId),
        menuTitle: "In-Room Dining",
        onSocketEvent: (event, data) {
          debugPrint("Socket event: $event $data");
        },
        // bottomBar: const BottomLayout(),
        // backgroundImage: "assets/images/bg.jpg",
        // hotelLogo : "assets/images/bg.jpg",
        // backgroundImage: "https://images.unsplash.com/photo-1615715035715-035123255873?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        // hotelLogo: "https://images.unsplash.com/photo-1598214886806-c87b84b7078b?q=80&w=1025&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ),
    );
  }

  loadAuthToken() {
    var currentTime = DateTime.now().millisecondsSinceEpoch;

    String data =
        "{\"serial_num\":\"$kSerialNumber\",\"time\":\"$currentTime\"}";

    final key = encrypt.Key.fromUtf8(kEncryptionKey);
    final iv = encrypt.IV.fromUtf8(kEncryptionIV);

    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );

    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64;
  }
}
