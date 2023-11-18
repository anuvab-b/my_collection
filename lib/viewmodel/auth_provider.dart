import 'package:flutter/cupertino.dart';
import 'package:my_collection/utils/secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> checkIfUserLoggedIn() async {
    String? userId =
        await SecureStorageManager().readSecureStorageData("user_id");
    return userId != null;
  }
}
