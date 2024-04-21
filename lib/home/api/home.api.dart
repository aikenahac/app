import 'package:coinseek/core/api/api_client.dart';
import 'package:coinseek/home/api/models/coin.model.dart';
import 'package:coinseek/home/api/models/report-location.model.dart';
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
    final res = await ApiClient.post('/location', body);
    final coins = (List<Map<String, dynamic>>.from(res['coins']))
        .map(CoinModel.fromJson)
        .toList();
    return coins;
  }
}
