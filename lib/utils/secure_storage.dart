import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grid_mobile/constants/env/env.dart';

class SecureStorage {
  static IOSOptions getIOSOptions() => const IOSOptions(synchronizable: true);

  static AndroidOptions getAndroidOptions() => AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: Env.securePrefName,
        resetOnError: true,
        // preferencesKeyPrefix: 'Test'
      );
}
