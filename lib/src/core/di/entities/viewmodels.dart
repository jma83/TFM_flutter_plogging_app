import 'package:flutter_plogging/src/core/application/create_user.dart';
import 'package:flutter_plogging/src/core/application/update_user.dart';
import 'package:flutter_plogging/src/core/application/generate_new_polyline.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/application/get_user_following.dart';
import 'package:flutter_plogging/src/core/application/get_users_by_ids.dart';
import 'package:flutter_plogging/src/core/application/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/search_route_list.dart';
import 'package:flutter_plogging/src/core/application/get_followers_route_list.dart';
import 'package:flutter_plogging/src/core/application/search_user_list.dart';
import 'package:flutter_plogging/src/core/application/calculate_points_distance.dart';
import 'package:flutter_plogging/src/core/application/check_user_followed.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_id.dart';
import 'package:flutter_plogging/src/core/domain/route_progress_data.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/edit_profile_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/home_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/my_routes_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/profile_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/route_detail_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/search_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/start_plogging_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/user_detail_page_view_model.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/image_picker_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tab_bar_viewmodel.dart';

final getIt = GetIt.instance;

void $initViewModels() {
  getIt
    ..registerFactory<HomeTabBarViewModel>(() => HomeTabBarViewModel(
        getIt<AuthenticationService>(),
        getIt<GetUserById>(),
        getIt<NavigationService>(),
        getIt<LoadingService>()))
    ..registerFactory<UserViewModel>(() => UserViewModel())
    ..registerFactory<StartPageViewModel>(() => StartPageViewModel(
        getIt<AuthenticationService>(), getIt<GetUserById>()))
    ..registerFactory<RegisterPageViewModel>(() => RegisterPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<LoadingService>(),
        getIt<CreateUser>(),
        getIt<GetUserById>()))
    ..registerFactory<LoginPageViewModel>(() => LoginPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<LoadingService>(),
        getIt<GetUserById>()))
    ..registerFactory<HomePageViewModel>(() => HomePageViewModel(
        getIt<AuthenticationService>(),
        getIt<GetFollowersRouteList>(),
        getIt<ManageLikeRoute>(),
        getIt<LoadingService>(),
        getIt<GetUsersByIds>()))
    ..registerFactory<StartPloggingPageViewModel>(() =>
        StartPloggingPageViewModel(
            getIt<AuthenticationService>(),
            getIt<RouteModel>(),
            getIt<GeolocatorService>(),
            getIt<UuidGeneratorService>(),
            getIt<ImagePickerService>(),
            RouteProgressData(id: getIt<UuidGeneratorService>().generate()),
            getIt<CalculatePointsDistance>(),
            getIt<GenerateNewPolyline>()))
    ..registerFactory<MyRoutesPageViewModel>(() => MyRoutesPageViewModel(
        getIt<AuthenticationService>(),
        getIt<ManageLikeRoute>(),
        getIt<GetRouteListByUser>(),
        getIt<SearchRouteList>(),
        getIt<LoadingService>()))
    ..registerFactory<ProfilePageViewModel>(() => ProfilePageViewModel(
        getIt<AuthenticationService>(), getIt<LoadingService>()))
    ..registerFactory<SearchPageViewModel>(() => SearchPageViewModel(
        getIt<AuthenticationService>(),
        getIt<ManageFollowUser>(),
        getIt<GetUserFollowing>(),
        getIt<SearchUserList>(),
        getIt<LoadingService>()))
    ..registerFactory<RouteDetailPageViewModel>(() => RouteDetailPageViewModel(
        getIt<AuthenticationService>(),
        getIt<ManageLikeRoute>(),
        getIt<CalculatePointsDistance>(),
        getIt<GenerateNewPolyline>(),
        getIt<UuidGeneratorService>().generate(),
        getIt<GetRouteListById>(),
        getIt<GetUserById>(),
        getIt<LoadingService>()))
    ..registerFactory<UserDetailPageViewModel>(() => UserDetailPageViewModel(
        getIt<AuthenticationService>(),
        getIt<GetRouteListByUser>(),
        getIt<ManageLikeRoute>(),
        getIt<ManageFollowUser>(),
        getIt<CheckUserFollowed>(),
        getIt<LoadingService>()))
    ..registerFactory<EditProfilePageViewModel>(() => EditProfilePageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<LoadingService>(),
        getIt<UpdateUser>()));
}
