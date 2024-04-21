import 'package:coinseek/home/api/models/coin.model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeDataModel {
  HomeDataModel({
    required this.coins,
    required this.markers,
  });

  final List<CoinModel> coins;
  final Set<Marker> markers;
}
