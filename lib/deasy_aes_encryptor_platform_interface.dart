import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'deasy_aes_encryptor_method_channel.dart';

abstract class DeasyAesEncryptorPlatform extends PlatformInterface {
  /// Constructs a DeasyAesEncryptorPlatform.
  DeasyAesEncryptorPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeasyAesEncryptorPlatform _instance = MethodChannelDeasyAesEncryptor();

  /// The default instance of [DeasyAesEncryptorPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeasyAesEncryptor].
  static DeasyAesEncryptorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeasyAesEncryptorPlatform] when
  /// they register themselves.
  static set instance(DeasyAesEncryptorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> encrypt(String plainText, String key) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> decrypt(String plainText, String key) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
