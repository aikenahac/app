import 'package:flutter/material.dart';

class AppAssets {
  static AppColors colors = AppColors();
  static AppImages images = AppImages();
}

class AppColors {
  Color black = Colors.black;
  Color white = const Color(0xffFAF9F6);
  Color grey = Colors.white.withOpacity(0.4);
  Color red = const Color(0xffEF2917);
  Color lightOrange = const Color(0xffFF9F1C);
  Color darkOrange = const Color(0xffFFBF69);
  Color lightGreen = const Color(0xffCBF3F0);
  Color darkGreen = const Color(0xff2EC4B6);
}

class AppImages {
  String markerIcon = 'assets/markers/coin_marker.png';
  String coinIcon = 'assets/coin.png';
  String profilePicture = 'assets/pfp.png';
  String blindOthersPowerup = 'assets/icons/blind_others.png';
  String spawnMultiplierPowerup = 'assets/icons/spawn_multiplier.png';
  String logo = 'assets/logo.png';
}
