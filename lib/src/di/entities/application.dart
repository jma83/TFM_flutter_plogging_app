import 'package:flutter_plogging/src/core/application/calculate_points_distance.dart';
import 'package:flutter_plogging/src/core/application/check_user_followed.dart';
import 'package:flutter_plogging/src/core/application/create_route.dart';
import 'package:flutter_plogging/src/core/application/generate_new_polyline.dart';
import 'package:flutter_plogging/src/core/application/get_following_route_list.dart';
import 'package:flutter_plogging/src/core/application/get_liked_routes_list.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_id.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/get_today_user_distance.dart';
import 'package:flutter_plogging/src/core/application/get_top_level_users.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/application/get_user_followers.dart';
import 'package:flutter_plogging/src/core/application/get_user_following.dart';
import 'package:flutter_plogging/src/core/application/get_users_by_ids.dart';
import 'package:flutter_plogging/src/core/application/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/search_route_list.dart';
import 'package:flutter_plogging/src/core/application/search_user_list.dart';
import 'package:flutter_plogging/src/core/application/create_user.dart';
import 'package:flutter_plogging/src/core/application/update_user.dart';
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
