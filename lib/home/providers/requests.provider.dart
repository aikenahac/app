import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/home/api/models/user.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'requests.provider.g.dart';

@riverpod
class AsyncRequests extends _$AsyncRequests {
  Future<List<UserModel>> _fetchFriendRequests() async {
    final requests = await CSApi.home.getFriendRequests();

    return requests;
  }

  @override
  FutureOr<List<UserModel>> build() async {
    return await _fetchFriendRequests();
  }
}
