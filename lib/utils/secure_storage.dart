import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static IOSOptions getIOSOptions() => const IOSOptions(synchronizable: true);

  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: 'petakita',
        resetOnError: true,
        // preferencesKeyPrefix: 'Test'
      );
}
