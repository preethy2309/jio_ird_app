import 'package:encrypt/encrypt.dart' as encrypt;

class AuthEncryption {
  String getIv() => "5b5bc6c117391111";
  String getKey() => "4db779e269dc587dd171516a86a62913";

  Future<String> getAuthToken() async {
    // Serial number (later replace with PlatformInfo.getDeviceSerialNumber())
    final result = "RPCSBII00015737";
    var currentTime = DateTime.now().millisecondsSinceEpoch;

    String data = "{\"serial_num\":\"$result\",\"time\":\"$currentTime\"}";

    final key = encrypt.Key.fromUtf8(getKey());
    final iv = encrypt.IV.fromUtf8(getIv());

    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );

    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64; // final token
  }
}
