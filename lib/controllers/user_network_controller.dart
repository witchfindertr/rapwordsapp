import 'package:foap/apiHandler/api_controller.dart';
import 'package:foap/helper/imports/common_import.dart';
import 'package:foap/model/user_model.dart';
import 'package:get/get.dart';

import '../apiHandler/apis/users_api.dart';

class UserNetworkController extends GetxController {
  RxList<UserModel> followers = <UserModel>[].obs;
  RxList<UserModel> following = <UserModel>[].obs;

  RxBool isLoading = true.obs;

  int page = 1;
  bool canLoadMore = true;

  clear() {
    page = 1;
    canLoadMore = true;
    isLoading.value = false;

    following.value = [];
    followers.value = [];
  }

  getFollowers(int userId) {
    if (canLoadMore) {
      isLoading.value = true;

      UsersApi.getFollowerUsers(
          userId: userId,
          page: page,
          resultCallback: (result, metadata) {
            isLoading.value = false;
            followers.addAll(result);

            page += 1;
            canLoadMore =  result.length >= metadata.perPage;

            update();
          });
    }
  }

  getFollowingUsers(int userId) {
    if (canLoadMore) {
      isLoading.value = true;

      UsersApi.getFollowingUsers(
          page: page,
          userId: userId,
          resultCallback: (result, metadata) {
            isLoading.value = false;
            following.addAll(result);

            page += 1;
            canLoadMore = result.length >= metadata.perPage;

            update();
          });
    }
  }

  followUser(UserModel user) {
    user.isFollowing = true;
    if (following.where((e) => e.id == user.id).isNotEmpty) {
      following[following.indexWhere((element) => element.id == user.id)] =
          user;
    }
    if (followers.where((e) => e.id == user.id).isNotEmpty) {
      followers[followers.indexWhere((element) => element.id == user.id)] =
          user;
    }
    update();
    UsersApi.followUnfollowUser(isFollowing: true, userId: user.id)
        .then((value) {
      update();
    });
  }

  unFollowUser(UserModel user) {
    user.isFollowing = false;
    if (following.where((e) => e.id == user.id).isNotEmpty) {
      following[following.indexWhere((element) => element.id == user.id)] =
          user;
    }
    if (followers.where((e) => e.id == user.id).isNotEmpty) {
      followers[followers.indexWhere((element) => element.id == user.id)] =
          user;
    }
    update();
    UsersApi.followUnfollowUser(isFollowing: false, userId: user.id)
        .then((value) {
      update();
    });
  }
}
