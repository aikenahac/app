import 'package:coinseek/home/api/models/coin.model.dart';
import 'package:coinseek/home/api/models/user.model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeDataModel {
  HomeDataModel({
    required this.coins,
    required this.markers,
    required this.user,
  });

  final List<CoinModel> coins;
  final Set<Marker> markers;
  final UserModel? user;
}
