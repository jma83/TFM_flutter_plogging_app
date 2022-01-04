import 'package:flutter/cupertino.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';

class HomeTabBarViewModel extends AuthPropertyChangeNotifier {
  final NavigationService _navigationService;
  final LoadingService _loadingService;
  final List<TabItem> _instantiatedTabItems = [];
  int _selectedIndexTab = 0;
  HomeTabBarViewModel(AuthenticationService authService,
      GetUserById getUserById, this._navigationService, this._loadingService)
      : super(authService, getUserById) {
    createAuthListener();
  }

  setSelectedIndex(int index) {
    _selectedIndexTab = index;
  }

  Future<bool> returnToPrevious() {
    final coordinators = getHomeTabsByCoordinator();
    return coordinators[selectedTabItem]!.returnToPrevious();
  }

  @override
  notifyNotLoggedIn() {
    _loadingService.setLoading(true);
    notifyListeners(HomeTabsNotifiers.homeTabsLogout);
  }

  onClickTab(int index) {
    setSelectedIndex(index);
    setCurrentHomeTabItem(selectedTabItem);
    notifyListeners(HomeTabsNotifiers.updateHomeTabs);
  }

  setCurrentHomeTabItem(TabItem item) {
    _navigationService.setCurrentHomeTabItem(item);
  }

  addInstantiatedTabItems(TabItem item) {
    _instantiatedTabItems.add(item);
    notifyListeners(HomeTabsNotifiers.updateHomeTabs);
  }

  updateItemsList() {
    if (!_instantiatedTabItems.contains(selectedTabItem)) {
      _instantiatedTabItems.add(selectedTabItem);
    }
  }

  bool checkIsInstantiated(TabItem tabItem) {
    return _instantiatedTabItems.contains(tabItem) ||
        selectedTabItem == tabItem;
  }

  Map<TabItem, String> get homeTabsRoutesMap {
    return _navigationService.homeTabsRoutesMap;
  }

  Map<TabItem, GlobalKey<NavigatorState>> get homeNavigatorKeys {
    return _navigationService.homeNavigatorKeys;
  }

  int get selectedIndex {
    return _selectedIndexTab;
  }

  TabItem get selectedTabItem {
    switch (_selectedIndexTab) {
      case 1:
        return TabItem.search;
      case 2:
        return TabItem.plogging;
      case 3:
        return TabItem.myRoutes;
      case 4:
        return TabItem.profile;
      case 0:
      default:
        return TabItem.home;
    }
  }
}
