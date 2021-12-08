import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/services/follower_store_service.dart';
import 'package:flutter_plogging/src/core/services/like_store_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageViewModel extends HomeTabsChangeNotifier {
  final RouteStoreService _routeStoreService;
  final FollowerStoreService _followerStoreService;
  final LikeStoreService _likeStoreService;
  List<RouteListData> _routes = [];
  HomePageViewModel(authenticationService, this._routeStoreService,
      this._followerStoreService, this._likeStoreService)
      : super(authenticationService);

  Future<void> loadPage() async {
    final List<FollowerData> followers = await _followerStoreService
        .queryElementEqualByCriteria(FollowerFieldData.userId, currenUserId);

    final List<String> userFollowingIds =
        followers.map((e) => e.userFollowedId).toList();
    final routes = await _routeStoreService.queryElementInCriteria(
        RouteFieldData.userId, userFollowingIds);
    // BUSCAR LIKES EN LA LISTA DE RUTAS CARGADAS -> By currentUser and in routes
    // final _likeStoreService.q
    _routes =
        routes.map((e) => RouteListData(routeData: e, isLiked: false)).toList();
  }

  List<RouteListData> get routes {
    return _routes;
  }

  String get username {
    return currentUser.username;
  }

  int get age {
    return currentUser.age;
  }

  int get gender {
    return currentUser.gender;
  }

  String getDateFormat(RouteListData route) {
    return DateCustomUtils.dateTimeToStringFormat(route.endDate!.toDate());
  }
}
