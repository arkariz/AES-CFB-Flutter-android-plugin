import 'package:flutter_test/flutter_test.dart';
import 'package:deasy_aes_encryptor/deasy_aes_encryptor.dart';
import 'package:deasy_aes_encryptor/deasy_aes_encryptor_platform_interface.dart';
import 'package:deasy_aes_encryptor/deasy_aes_encryptor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeasyAesEncryptorPlatform
    with MockPlatformInterfaceMixin
    implements DeasyAesEncryptorPlatform {
  
  @override
  Future<String?> decrypt(String plainText, String key) => Future.value('plaintext');
  
  @override
  Future<String?> encrypt(String plainText, String key) => Future.value('ciphertext');
}

void main() {
  final DeasyAesEncryptorPlatform initialPlatform = DeasyAesEncryptorPlatform.instance;

  test('$MethodChannelDeasyAesEncryptor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeasyAesEncryptor>());
  });

  test('encrypt', () async {
    DeasyAesEncryptor deasyAesEncryptorPlugin = DeasyAesEncryptor("testKey");
    MockDeasyAesEncryptorPlatform fakePlatform = MockDeasyAesEncryptorPlatform();
    DeasyAesEncryptorPlatform.instance = fakePlatform;

    expect(await deasyAesEncryptorPlugin.encrypt("plaintext"), 'ciphertext');
  });

  test('decrypt', () async {
    DeasyAesEncryptor deasyAesEncryptorPlugin = DeasyAesEncryptor("testKey");
    MockDeasyAesEncryptorPlatform fakePlatform = MockDeasyAesEncryptorPlatform();
    DeasyAesEncryptorPlatform.instance = fakePlatform;

    expect(await deasyAesEncryptorPlugin.decrypt("ciphertext"), 'plaintext');
  });
}
