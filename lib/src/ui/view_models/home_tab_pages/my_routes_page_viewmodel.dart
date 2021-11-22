import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';

class MyRoutesPageViewModel extends HomeTabsChangeNotifier {
  List<RouteData> _routes = [];
  String _searchValue = "";
  bool _isLoading = false;
  RouteStoreService _routeStoreService;
  MyRoutesPageViewModel(authService, this._routeStoreService)
      : super(authService);

  setSearchValue(String value) {
    _searchValue = value;
  }

  Future<void> submitSearch(String value) async {
    toggleLoading();
    final userId = authenticationService.currentUser!.uid;
    if (value.isEmpty) {
      _routes = await _routeStoreService.queryElementEqualByCriteria(
          RouteFieldData.userId, userId);
      toggleLoading();
      return;
    }
    _routes =
        await _routeStoreService.searchRoutesByNameAndAuthor(value, userId);

    toggleLoading();
    notifyListeners("update_my_routes");
  }

  toggleLoading() {
    _isLoading ? EasyLoading.dismiss() : EasyLoading.show(status: 'loading...');
    _isLoading = !_isLoading;
  }

  String get searchValue {
    return _searchValue;
  }

  List<RouteData> get routes {
    return _routes;
  }
}
