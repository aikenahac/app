import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/home/api/models/home.model.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data.provider.g.dart';

@riverpod
class AsyncData extends _$AsyncData {
  Future<HomeDataModel> _fetchHomeData() async {
    final coins = await CSApi.home.getCoins();
    final user = await CSApi.home.getUserInfo();

    final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), AppAssets.images.markerIcon);

    final markers = coins
        .map((coin) => Marker(
              markerId: MarkerId(coin.id),
              position: coin.location,
              icon: icon,
            ))
        .toSet();

    return HomeDataModel(coins: coins, markers: markers, user: user);
  }

  @override
  FutureOr<HomeDataModel> build() async {
    return _fetchHomeData();
  }

  void clear() {
    state = AsyncValue.data(
        HomeDataModel(coins: [], markers: <Marker>{}, user: null));
  }
}
