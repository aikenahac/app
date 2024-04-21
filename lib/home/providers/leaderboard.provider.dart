import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/home/api/models/user.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leaderboard.provider.g.dart';

@riverpod
class AsyncLeaderboard extends _$AsyncLeaderboard {
  @override
  FutureOr<List<UserModel>> build() async {
    return await CSApi.home.getFriends();
  }
}
