import 'package:coinseek/core/api/api_client.dart';
import 'package:coinseek/home/api/models/coin.model.dart';

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
}
