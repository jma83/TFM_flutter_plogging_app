import 'package:flutter_plogging/src/core/application/route/calculate_points_distance.dart';
import 'package:flutter_plogging/src/core/application/follower/check_user_followed.dart';
import 'package:flutter_plogging/src/core/application/route/create_route.dart';
import 'package:flutter_plogging/src/core/application/route/generate_new_polyline.dart';
import 'package:flutter_plogging/src/core/application/follower/get_following_route_list.dart';
import 'package:flutter_plogging/src/core/application/like/get_liked_routes_list.dart';
import 'package:flutter_plogging/src/core/application/route/get_route_list_by_id.dart';
import 'package:flutter_plogging/src/core/application/route/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/route/get_today_user_distance.dart';
import 'package:flutter_plogging/src/core/application/user/get_top_level_users.dart';
import 'package:flutter_plogging/src/core/application/follower/get_user_followers.dart';
import 'package:flutter_plogging/src/core/application/follower/get_user_following.dart';
import 'package:flutter_plogging/src/core/application/follower/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/like/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/route/search_route_list.dart';
import 'package:flutter_plogging/src/core/application/user/create_user.dart';
import 'package:flutter_plogging/src/core/application/user/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/application/user/get_users_by_ids.dart';
import 'package:flutter_plogging/src/core/application/user/search_user_list.dart';
import 'package:flutter_plogging/src/core/application/user/update_user.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initApplication() {
  getIt
    ..registerLazySingleton<ManageLikeRoute>(() => ManageLikeRoute(
        getIt<LikeModel>(),
        getIt<UuidGeneratorService>(),
        getIt<AuthenticationService>()))
    ..registerLazySingleton<GetRouteListByUser>(() => GetRouteListByUser(
        getIt<RouteModel>(),
        getIt<LikeModel>(),
        getIt<AuthenticationService>()))
    ..registerLazySingleton<SearchRouteList>(
        () => SearchRouteList(getIt<RouteModel>(), getIt<LikeModel>()))
    ..registerLazySingleton<GetFollowingRouteList>(() => GetFollowingRouteList(
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
        () => SearchUserList(getIt<UserModel>()))
    ..registerLazySingleton<GetUserById>(() => GetUserById(getIt<UserModel>()))
    ..registerLazySingleton<GetUsersByIds>(
        () => GetUsersByIds(getIt<UserModel>()))
    ..registerLazySingleton<CalculatePointsDistance>(
        () => CalculatePointsDistance(getIt<GeolocatorService>()))
    ..registerLazySingleton<GenerateNewPolyline>(() => GenerateNewPolyline(
        getIt<GeolocatorService>(), getIt<UuidGeneratorService>()))
    ..registerLazySingleton<CheckUserFollowed>(() => CheckUserFollowed(
        getIt<FollowerModel>(), getIt<AuthenticationService>()))
    ..registerLazySingleton<GetRouteListById>(() => GetRouteListById(
        getIt<RouteModel>(),
        getIt<LikeModel>(),
        getIt<AuthenticationService>()))
    ..registerLazySingleton<CreateUser>(() => CreateUser(getIt<UserModel>()))
    ..registerLazySingleton<CreateRoute>(() => CreateRoute(getIt<RouteModel>()))
    ..registerLazySingleton<UpdateUser>(
        () => UpdateUser(getIt<UserModel>(), getIt<AuthenticationService>()))
    ..registerLazySingleton<GetTodayUserDistance>(() => GetTodayUserDistance(
        getIt<RouteModel>(), getIt<AuthenticationService>()))
    ..registerLazySingleton<GetLikedRoutesList>(
        () => GetLikedRoutesList(getIt<RouteModel>(), getIt<LikeModel>()))
    ..registerLazySingleton<GetTopLevelUsers>(
        () => GetTopLevelUsers(getIt<UserModel>()));
}
