// ignore: implementation_imports
import 'dart:async';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';

class HomeTabBarViewModel extends AuthPropertyChangeNotifier {
  final NavigationService _navigationService;
  final LoadingService _loadingService;
  final List<TabItem> _instantiatedTabItems = [];
  final List<BottomNavigationBarItem> _bottomNavBarItems;
  final Map<int, TabItem> _tabsMap;
  int _selectedIndexTab = 0;
  StreamSubscription<TabItem?>? tabSubscription;
  HomeTabBarViewModel(
      AuthenticationService authService,
      GetUserById getUserById,
      this._navigationService,
      this._loadingService,
      this._bottomNavBarItems,
      this._tabsMap)
      : super(authService, getUserById) {
    createAuthListener("HOME TAB");
    _createHomeTabListener();
  }

  _createHomeTabListener() {
    tabSubscription = _navigationService.getStreamHomeTabItem().listen((event) {
      if (event == null || event == selectedTabItem) {
        return; //notifyListeners(HomeTabsNotifiers.updateHomeTabs);
      }
      if (!checkIsInstantiated(event)) {
        notifyListeners(HomeTabsNotifiers.instanceHomeTab);
      }
      _setSelectedIndex(getIndexFromTab(event));
      notifyListeners(HomeTabsNotifiers.updateHomeTabs);
    });
  }

  _setSelectedIndex(int index) {
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

  initFirstTab() {
    _updateTabItemNavigator(getTabFromIndex(0));
  }

  onClickTab(int index) {
    if (index == selectedIndex) return;
    _updateTabItemNavigator(getTabFromIndex(index));
  }

  _updateTabItemNavigator(TabItem item) {
    _navigationService.setCurrentHomeTabItem(item);
  }

  updateInstantiatedList() {
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
    return _tabsMap[_selectedIndexTab]!;
  }

  List<BottomNavigationBarItem> get bottomNavBarItems {
    return _bottomNavBarItems;
  }

  TabItem getTabFromIndex(int index) {
    return _tabsMap[index] ?? _tabsMap[0]!;
  }

  int getIndexFromTab(TabItem tab) {
    return _tabsMap.entries.firstWhereOrNull((e) => e.value == tab)?.key ?? 0;
  }

  @override
  void dispose() {
    tabSubscription?.cancel();
    tabSubscription = null;
  }
}
