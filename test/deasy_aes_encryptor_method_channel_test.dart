import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deasy_aes_encryptor/deasy_aes_encryptor_method_channel.dart';

void main() {
  MethodChannelDeasyAesEncryptor platform = MethodChannelDeasyAesEncryptor();
  const MethodChannel channel = MethodChannel('deasy_aes_encryptor');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('encrypt', () async {
    expect(await platform.encrypt("plaintext", "key"), '42');
  });
}
