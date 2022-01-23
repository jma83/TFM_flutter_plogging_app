import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/tabs/tab_navigatior.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tab_bar_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeTabBar extends StatelessWidget {
  final HomeTabBarViewModel viewModel;
  const HomeTabBar(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewModel.onClickTab(0);
    return ViewModelBuilder<HomeTabBarViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(() {}, [HomeTabsNotifiers.updateHomeTabs]);
        },
        builder: (context, HomeTabBarViewModel viewModel, child) {
          return WillPopScope(
              onWillPop: () async => await viewModel.returnToPrevious(),
              child: Scaffold(
                  body: Stack(children: getTabs()),
                  bottomNavigationBar: getBottomNavigationBar()));
        });
  }

  List<Widget> getTabs() {
    List<Widget> tabs = [];
    viewModel.homeTabsRoutesMap.forEach((key, value) {
      tabs.add(getOffstageTabNavigator(key, value));
    });
    return tabs;
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      type: BottomNavigationBarType.fixed,
      items: viewModel.navbarItems,
      currentIndex: viewModel.selectedIndex,
      selectedItemColor: Colors.green[700],
      unselectedItemColor: Colors.white60,
      unselectedLabelStyle: const TextStyle(color: Colors.black87),
      onTap: (index) => viewModel.onClickTab(index),
    );
  }

  Widget getOffstageTabNavigator(TabItem tabItem, String route) {
    viewModel.updateItemsList();
    final bool isInstanciated = viewModel.checkIsInstantiated(tabItem);

    return Offstage(
      offstage: viewModel.selectedTabItem != tabItem,
      child: !isInstanciated
          ? Container()
          : TabNavigator(
              navigatorKey: viewModel.homeNavigatorKeys[tabItem]!,
              tabItem: tabItem,
              initialRoute: route),
    );
  }
}
