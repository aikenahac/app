import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoinModel {
  CoinModel({
    required this.id,
    required this.location,
    required this.value,
  });

  late String id;
  late LatLng location;
  late int value;

  CoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    location = LatLng(json['location'][0], json['location'][1]);
    value = json['value'] as int;
  }
}
