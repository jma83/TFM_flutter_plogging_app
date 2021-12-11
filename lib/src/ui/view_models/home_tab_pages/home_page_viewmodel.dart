import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageViewModel extends HomeTabsChangeNotifier {
  final RouteModel _RouteModel;
  final FollowerModel _FollowerModel;
  final LikeModel _LikeModel;
  bool _isLoading = false;
  List<RouteListData> _routes = [];
  HomePageViewModel(authenticationService, this._RouteModel,
      this._FollowerModel, this._LikeModel)
      : super(authenticationService);

  Future<void> loadPage() async {
    toggleLoading();
    final List<FollowerData> followers =
        await _FollowerModel.queryElementEqualByCriteria(
            FollowerFieldData.userId, currenUserId);

    final List<String> userFollowingIds =
        followers.map((e) => e.userFollowedId).toList();
    final routes = await _RouteModel.queryElementInCriteria(
        RouteFieldData.userId, userFollowingIds);
    // BUSCAR LIKES EN LA LISTA DE RUTAS CARGADAS -> By currentUser and in routes
    final likes = await _LikeModel.matchRoutesWithUserLikes(
        currenUserId, routes.map((e) => e.id!).toList());
    final likedRoutes = likes.map((e) => e.routeId);
    _routes = routes
        .map((e) =>
            RouteListData(routeData: e, isLiked: likedRoutes.contains(e.id)))
        .toList();
    toggleLoading();
    notifyListeners("update_home_page");
  }

  toggleLoading() {
    _isLoading ? EasyLoading.dismiss() : EasyLoading.show(status: 'loading...');
    _isLoading = !_isLoading;
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
