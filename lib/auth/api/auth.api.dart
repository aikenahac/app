import 'package:coinseek/utils/snackbar.util.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const csStorage = FlutterSecureStorage();

class AuthAPI {
  Future<void> saveToken(String? token) async {
    if (token == null) {
      showSnackbar('Error saving token. Please restart the app');
      return;
    }

    await csStorage.write(
      key: 'token',
      value: token,
    );
  }

  Future<String?> getToken() async {
    return await csStorage.read(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    return await csStorage.containsKey(key: 'token');
  }

  Future<void> deleteToken() async {
    await csStorage.deleteAll();
  }
}
