import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'deasy_aes_encryptor_platform_interface.dart';

/// An implementation of [DeasyAesEncryptorPlatform] that uses method channels.
class MethodChannelDeasyAesEncryptor extends DeasyAesEncryptorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('deasy_aes_encryptor');

  @override
  Future<String?> encrypt(String plainText, String key) async {
    final encryptedText = await methodChannel.invokeMethod<String>('encrypt', {"plainText": plainText, "key": key});
    return encryptedText;
  }

  @override
  Future<String?> decrypt(String plainText, String key) async {
    final decryptedText = await methodChannel.invokeMethod<String>('decrypt', {"plainText": plainText, "key": key});
    return decryptedText;
  }
}
