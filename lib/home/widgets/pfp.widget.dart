import 'package:coinseek/utils/assets.util.dart';
import 'package:flutter/material.dart';

class PfpWidget extends StatelessWidget {
  const PfpWidget({super.key, this.radius = 24.0});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppAssets.colors.lightOrange,
          blurRadius: 30,
          spreadRadius: -10,
          offset: const Offset(0, 20),
        ),
      ]),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(AppAssets.images.profilePicture),
      ),
    );
  }
}
