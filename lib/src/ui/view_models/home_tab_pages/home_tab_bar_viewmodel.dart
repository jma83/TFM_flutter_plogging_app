import 'dart:async';
// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plogging/src/core/application/user/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/domain/tabs/home_tabs_routes_map.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';

class HomeTabBarViewModel extends AuthPropertyChangeNotifier {
  final NavigationService _navigationService;
  final LoadingService _loadingService;
  final List<TabItem> _instantiatedTabItems = [];
  final List<BottomNavigationBarItem> navbarItems;
  final Map<int, TabItem> _tabsMap;
  final Map<TabItem, HomeTabRouteCoordinator> _coordinatorByTabs;
  StreamSubscription<TabItem?>? tabSubscription;
  int _selectedIndexTab = 0;
  HomeTabBarViewModel(
      AuthenticationService authService,
      GetUserById getUserById,
      this._navigationService,
      this._loadingService,
      this.navbarItems,
      this._tabsMap,
      this._coordinatorByTabs)
      : super(authService, getUserById) {
    createAuthListener();
    _navigationService.getStreamHomeTabItem().listen((event) {
      if (event == null) return;
      if (event == selectedTabItem) return;
      onClickTab(_getIndexFromTab(event), updateNavigator: false);
    });
  }

  setSelectedIndex(int index) {
    _selectedIndexTab = index;
  }

  Future<bool> returnToPrevious() {
    return _coordinatorByTabs[selectedTabItem]!.returnToPrevious();
  }

  Map<TabItem, HomeTabRouteCoordinator> getCoordinators() {
    return _coordinatorByTabs;
  }

  WidgetBuilder getRoutesBuilders(String route) {
    return (BuildContext context) =>
        _coordinatorByTabs[getHomeTabFromRoute(route)]!.getAndUpdateWidget();
  }

  HomeTabsChangeNotifier getViewModel(TabItem tab) {
    HomeTabRouteCoordinator homeTab = _coordinatorByTabs[tab]!;
    return homeTab.mainWidget.viewModel as HomeTabsChangeNotifier;
  }

  @override
  notifyNotLoggedIn() {
    _loadingService.setLoading(true);
    notifyListeners(HomeTabsNotifiers.homeTabsLogout);
  }

  onClickTab(int index, {bool updateNavigator = true, bool first = false}) {
    if (first) notifyListeners(HomeTabsNotifiers.instanceHomeTab);
    if (index == selectedIndex) return;
    setSelectedIndex(index);
    if (updateNavigator) setCurrentHomeTabItem(selectedTabItem);
    if (!checkIsInstantiated(selectedTabItem) && !first) {
      notifyListeners(HomeTabsNotifiers.instanceHomeTab);
    }
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
    return _instantiatedTabItems.contains(tabItem);
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
    return _getTabFromIndex(_selectedIndexTab);
  }

  TabItem _getTabFromIndex(int index) {
    return _tabsMap[index] ?? _tabsMap[0]!;
  }

  int _getIndexFromTab(TabItem tab) {
    return _tabsMap.entries.firstWhereOrNull((e) => e.value == tab)?.key ?? 0;
  }

  @override
  // ignore: must_call_super
  void dispose() {
    tabSubscription?.cancel();
    tabSubscription = null;
  }
}
