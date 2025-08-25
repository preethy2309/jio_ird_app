import 'package:encrypt/encrypt.dart' as encrypt;

import 'constants.dart';

class AuthEncryption {
  Future<String> getAuthToken() async {
    // Serial number (later replace with PlatformInfo.getDeviceSerialNumber())
    var currentTime = DateTime.now().millisecondsSinceEpoch;

    String data =
        "{\"serial_num\":\"$kSerialNumber\",\"time\":\"$currentTime\"}";

    final key = encrypt.Key.fromUtf8(kEncryptionKey);
    final iv = encrypt.IV.fromUtf8(kEncryptionIV);

    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );

    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64; // final token
  }
}
