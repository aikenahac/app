import 'package:coinseek/home/api/models/user.model.dart';
import 'package:coinseek/home/widgets/pfp.widget.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendRequestWidget extends ConsumerWidget {
  const FriendRequestWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const PfpWidget(),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(
                color: AppAssets.colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  AppAssets.images.coinIcon,
                  height: 15.0,
                  width: 15.0,
                ),
                const SizedBox(width: 3.0),
                Text(
                  user.balance.toString(),
                  style: TextStyle(
                    color: AppAssets.colors.black,
                  ),
                ),
              ],
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
            tr.accept,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
