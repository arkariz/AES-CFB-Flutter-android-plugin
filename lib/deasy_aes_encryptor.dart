
import 'deasy_aes_encryptor_platform_interface.dart';

class DeasyAesEncryptor {

  DeasyAesEncryptor(this.key);
  
  final String key;

  Future<String?> encrypt(String plainText) {
    return DeasyAesEncryptorPlatform.instance.encrypt(plainText, key);
  }

  Future<String?> decrypt(String plainText) {
    return DeasyAesEncryptorPlatform.instance.decrypt(plainText, key);
  }
}
