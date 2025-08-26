import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:jio_ird/jio_ird.dart';
import 'package:jio_ird_app/constants.dart';

void main() {
  runApp(const MyDemoApp());
}

class MyDemoApp extends StatelessWidget {
  const MyDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JioIRDScreen(
        focusTheme: const FocusTheme(
          focusedColor: Colors.amber,
          unfocusedColor: Color(0xFF430B42),
          focusedTextColor: Color(0xFF430B42),
          unfocusedTextColor: Colors.amber,
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
