import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage storage = getSecureStorage();

  SecureStorage._();

  static SecureStorage? _instance;

  static SecureStorage get instance {
    _instance ??= SecureStorage._();
    return _instance!;
  }

  static FlutterSecureStorage getSecureStorage() {
    AndroidOptions androidOptions = _getAndroidOptions();
    return FlutterSecureStorage(aOptions: androidOptions);
  }

  static AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  static IOSOptions _getIOSOptions() {
    return const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  }

  // Store sensitive information
  Future<void> storeSensitiveInfo<T>(String key, T value) async {
    await storage.write(
        key: key,
        value: value.toString(),
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  // Retrieve sensitive information
  Future<T?> getSensitiveInfo<T>(String key) async {
    final String? stringValue = await storage.read(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());

    if (stringValue == null) {
      return null;
    }

    switch (T) {
      case const (bool):
        return (stringValue.toLowerCase() == 'true') as T;
      case const (int):
        return int.tryParse(stringValue) as T?;
      case const (double):
        return double.tryParse(stringValue) as T?;
      default:
        return stringValue as T?;
    }
  }

  // Delete sensitive information
  Future<void> deleteSensitiveInfo(String key) async {
    await storage.delete(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  // Read all values
  Future<Map<String, String>> readAllValues() async {
    return await storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  // Delete all values
  Future<void> deleteAllValues() async {
    await storage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }
}
