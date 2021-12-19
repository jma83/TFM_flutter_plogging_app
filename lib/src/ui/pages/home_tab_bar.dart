import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/tabs/tab_navigatior.dart';

class HomeTabBar extends StatefulWidget {
  HomeTabBar(this.navbarItems, this._navigationService, {Key? key})
      : super(key: key);

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
  List<BottomNavigationBarItem> navbarItems = [];
  final NavigationService _navigationService;
}

class _HomeTabBarState extends State<HomeTabBar> {
  int _selectedIndex = 0;
  List<TabItem> _tabItemsList = [];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => !await widget._navigationService
            .homeNavigatorKeys[selectedTabItem]!.currentState!
            .maybePop(),
        child: Scaffold(
          body: Stack(children: getTabs()),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black87,
            type: BottomNavigationBarType.fixed,
            items: widget.navbarItems,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green[700],
            unselectedItemColor: Colors.white60,
            unselectedLabelStyle: const TextStyle(color: Colors.black87),
            onTap: _onItemTapped,
          ),
        ));
  }

  List<Widget> getTabs() {
    List<Widget> tabs = [];
    widget._navigationService.homeTabsRoutesMap.forEach((key, value) {
      tabs.add(_buildOffstageNavigator(key, value));
    });
    return tabs;
  }

  Widget _buildOffstageNavigator(TabItem tabItem, String route) {
    updateItemsList();
    final bool isInstanciated =
        _tabItemsList.contains(tabItem) || selectedTabItem == tabItem;
    return Offstage(
      offstage: selectedTabItem != tabItem,
      child: !isInstanciated
          ? Container()
          : TabNavigator(
              navigatorKey:
                  widget._navigationService.homeNavigatorKeys[tabItem]!,
              tabItem: tabItem,
              initialRoute: route,
            ),
    );
  }

  updateItemsList() {
    if (!_tabItemsList.contains(selectedTabItem)) {
      setState(() {
        _tabItemsList = [..._tabItemsList, selectedTabItem];
      });
    }
  }

  TabItem get selectedTabItem {
    switch (_selectedIndex) {
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
