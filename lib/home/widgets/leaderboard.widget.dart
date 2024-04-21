import 'package:coinseek/home/providers/leaderboard.provider.dart';
import 'package:coinseek/home/widgets/pfp.widget.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Leaderboard extends ConsumerWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboard = ref.watch(asyncLeaderboardProvider);

    return Column(
      children: [
        const SizedBox(height: 32.0),
        const Text('Leaderboard', style: TextStyle(fontSize: 24.0)),
        Expanded(
          child: leaderboard.map(
            data: (data) => ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: data.value.length,
              separatorBuilder: (c, i) => const SizedBox(height: 16.0),
              itemBuilder: (c, i) => Row(
                children: [
                  SizedBox(
                    width: 42.0,
                    child: Text(
                      '${i + 1}.',
                      style: const TextStyle(fontSize: 24.0),
                    ),
                  ),
                  const PfpWidget(),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.value[i].name,
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
                            data.value[i].balance.toString(),
                            style: TextStyle(
                              color: AppAssets.colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            error: (e) => Center(child: Text(e.toString())),
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
