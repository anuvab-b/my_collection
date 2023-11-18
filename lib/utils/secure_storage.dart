import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager{
  final _storage = const FlutterSecureStorage();

  Future<void> setSecureStorageData(String key,String? value) async {
    await _storage.write(
      key: key,
      value: value
    );
  }

  Future<dynamic> readSecureStorageData(String key) async {
    var result = await _storage.read(
        key: key,
    );
    return result;
  }

  /// Clear the logged in users data from local storage
  Future<void> logoutUser() async {
    var result = await _storage.deleteAll();
  }
}