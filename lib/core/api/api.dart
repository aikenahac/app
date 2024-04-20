import 'package:coinseek/core/api/api_client.dart';
import 'package:coinseek/home/api/home.api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CSApi {
  static final auth = FirebaseAuth.instance;
  static final home = HomeApi();

  static Future<void> setDisplayName(String displayName) async {
    await ApiClient.patch('/user');
  }

  static bool isSignedIn() {
    if (auth.currentUser != null) {
      return true;
    }

    return false;
  }
}
