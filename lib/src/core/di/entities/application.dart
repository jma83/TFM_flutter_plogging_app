import 'package:flutter_plogging/src/core/application/get_followers_route_list.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/get_user_followers.dart';
import 'package:flutter_plogging/src/core/application/get_user_following.dart';
import 'package:flutter_plogging/src/core/application/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/search_route_list.dart';
import 'package:flutter_plogging/src/core/application/search_user_list.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initApplication() {
  getIt
    ..registerLazySingleton<ManageLikeRoute>(() => ManageLikeRoute(
        getIt<LikeModel>(),
        getIt<UuidGeneratorService>(),
        getIt<AuthenticationService>()))
    ..registerLazySingleton<GetRouteListByUser>(
        () => GetRouteListByUser(getIt<RouteModel>(), getIt<LikeModel>()))
    ..registerLazySingleton<SearchRouteList>(
        () => SearchRouteList(getIt<RouteModel>(), getIt<LikeModel>()))
    ..registerLazySingleton<GetFollowersRouteList>(() => GetFollowersRouteList(
        getIt<FollowerModel>(), getIt<RouteModel>(), getIt<LikeModel>()))
    ..registerLazySingleton<GetUserFollowing>(
        () => GetUserFollowing(getIt<FollowerModel>()))
    ..registerLazySingleton<GetUserFollowers>(
        () => GetUserFollowers(getIt<FollowerModel>()))
    ..registerLazySingleton<ManageFollowUser>(() => ManageFollowUser(
        getIt<UuidGeneratorService>(),
        getIt<FollowerModel>(),
        getIt<UserModel>()))
    ..registerLazySingleton<SearchUserList>(
        () => SearchUserList(getIt<UserModel>()));
}
