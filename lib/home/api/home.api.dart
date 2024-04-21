import 'package:coinseek/core/api/api_client.dart';
import 'package:coinseek/home/api/models/coin.model.dart';
import 'package:coinseek/home/api/models/report-location.model.dart';
import 'package:coinseek/home/api/models/user.model.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:coinseek/utils/snackbar.util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeApi {
  Future<List<CoinModel>> getCoins() async {
    final resp = await ApiClient.getMany('/coins');
    final List<CoinModel> coins = [];

    for (var c in resp) {
      CoinModel newCoin = CoinModel.fromJson(c);
      coins.add(newCoin);
    }

    return coins;
  }

  Future<List<CoinModel>> reportLocation(LatLng location) async {
    final body = ReportLocation(location: location).toJson();
    final resp = await ApiClient.post('/location', body);
    final coins = (List<Map<String, dynamic>>.from(resp['coins']))
        .map(CoinModel.fromJson)
        .toList();
    return coins;
  }

  Future<UserModel?> getUserInfo() async {
    final resp = await ApiClient.get('/user');

    if (resp == null) {
      showSnackbar(tr.restart_app_error);
      return null;
    }

    final user = UserModel.fromJson(resp);

    return user;
  }

  Future<void> sendFriendRequest(String email) async {
    await ApiClient.post('/friends/request', {
      "email": email,
    });
  }

  Future<List<UserModel>> getFriendRequests() async {
    final resp = await ApiClient.getMany('/friends/requests');
    final List<UserModel> requests = [];

    for (final req in resp) {
      final parsedRequest = UserModel.fromJson(req);
      requests.add(parsedRequest);
    }

    return requests;
  }

  Future<void> acceptFriendRequest(String email) async {
    await ApiClient.post('/friends/accept', {
      "email": email,
    });
  }

  Future<List<UserModel>> getFriends() async {
    final res = await ApiClient.getMany('/friends');
    return res.map((u) => UserModel.fromJson(u)).toList();
  }

  Future<void> updateAnchorPoint(LatLng location) async {
    await ApiClient.patch('/user', {
      "centerPoint": [location.latitude, location.longitude]
    });
  }

  Future<void> updateName(String name) async {
    await ApiClient.patch('/user', {
      "name": name,
    });
  }
}
