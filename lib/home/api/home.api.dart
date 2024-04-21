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

  Future<void> sendFriendRequest(String friend) async {
    await ApiClient.post('/friends/request', {
      "email": friend,
    });
  }

  Future<List<UserModel>> getFriendRequests() async {
    final resp = await ApiClient.getMany('/friends/requests');
    final List<UserModel> requests = [];

    for (var req in resp) {
      final parsedRequest = UserModel.fromJson(req);
      requests.add(parsedRequest);
    }

    return requests;
  }
}
