import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:flutter/material.dart';

class PowerupWidget extends StatelessWidget {
  const PowerupWidget({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
  });

  final String name;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Image.asset(
            icon,
            height: 40.0,
            width: 40.0,
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: AppAssets.colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: AppAssets.colors.black,
                ),
              )
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: AppAssets.colors.darkGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
                side: BorderSide(
                  color: AppAssets.colors.darkGreen,
                  width: 0.5,
                ),
              ),
            ),
            child: Text(
              '${tr.buy}: 10 C',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
