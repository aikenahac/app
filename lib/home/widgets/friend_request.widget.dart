import 'package:coinseek/home/api/models/user.model.dart';
import 'package:coinseek/home/widgets/pfp.widget.dart';
import 'package:coinseek/utils/assets.util.dart';
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
        Column(
          children: [
            Text(
              user.name,
              style: TextStyle(
                color: AppAssets.colors.black,
              ),
            ),
            Text(
              user.balance.toString(),
              style: TextStyle(
                color: AppAssets.colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
