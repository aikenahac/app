import 'package:coinseek/core/api/api_client.dart';
import 'package:coinseek/home/api/home.api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class CSApi {
  static final auth = FirebaseAuth.instance;
  static final home = HomeApi();

  static Future<void> setDisplayNameAndAnchor(
      String displayName, Position? pos) async {
    final Map<String, dynamic> body = {
      "name": displayName,
    };

    if (pos != null) {
      body.addAll({
        "centerPoint": [pos.latitude, pos.longitude]
      });
    }

    await ApiClient.patch('/user', body);
  }

  static bool isSignedIn() {
    if (auth.currentUser != null) {
      return true;
    }

    return false;
  }
}
