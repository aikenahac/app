import 'package:coinseek/utils/assets.util.dart';
import 'package:flutter/material.dart';

class HomePanelCollapsedWidget extends StatelessWidget {
  const HomePanelCollapsedWidget({
    super.key,
    required this.balance,
  });

  final String balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CoinCountWidget(balance: balance),
        ],
      ),
    );
  }
}

class CoinCountWidget extends StatelessWidget {
  const CoinCountWidget({
    super.key,
    required this.balance,
  });

  final String balance;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.images.coinIcon,
          height: 40.0,
          width: 40.0,
        ),
        const SizedBox(width: 5.0),
        Text(
          balance,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        )
      ],
    );
  }
}
