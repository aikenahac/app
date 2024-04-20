import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/home/api/models/home.model.dart';
import 'package:coinseek/home/providers/location.provider.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data.provider.g.dart';

@riverpod
class AsyncData extends _$AsyncData {
  Future<HomeDataModel> _fetchHomeData() async {
    final coins = await CSApi.home.getCoins();
    final Set<Marker> markers = {};

    for (var coin in coins) {
      Marker marker = Marker(
        markerId: MarkerId(coin.id),
        position: coin.location,
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), AppAssets.images.markerIcon),
      );
      markers.add(marker);
    }

    ref.read(coinMarkersProvider.notifier).state = markers;

    return HomeDataModel(coins: coins);
  }

  @override
  FutureOr<HomeDataModel> build() async {
    return _fetchHomeData();
  }
}
