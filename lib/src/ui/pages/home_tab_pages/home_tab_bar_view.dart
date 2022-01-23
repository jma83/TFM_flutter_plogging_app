import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/page_widget.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/components/tab_navigator.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tab_bar_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeTabBarView extends PageWidget {
  const HomeTabBarView(HomeTabBarViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    currentViewModel.onClickTab(0, first: true);
    return ViewModelBuilder<HomeTabBarViewModel>.reactive(
        viewModelBuilder: () => viewModel as HomeTabBarViewModel,
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
    currentViewModel.homeTabsRoutesMap.forEach((key, value) {
      tabs.add(getOffstageTabNavigator(key, value));
    });
    return tabs;
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      type: BottomNavigationBarType.fixed,
      items: currentViewModel.navbarItems,
      currentIndex: currentViewModel.selectedIndex,
      selectedItemColor: Colors.green[700],
      unselectedItemColor: Colors.white60,
      unselectedLabelStyle: const TextStyle(color: Colors.black87),
      onTap: (index) => currentViewModel.onClickTab(index),
    );
  }

  Widget getOffstageTabNavigator(TabItem tabItem, String route) {
    currentViewModel.updateItemsList();
    final bool isInstanciated = currentViewModel.checkIsInstantiated(tabItem);

    return Offstage(
      offstage: currentViewModel.selectedTabItem != tabItem,
      child: !isInstanciated
          ? Container()
          : TabNavigator(
              navigatorKey: currentViewModel.homeNavigatorKeys[tabItem]!,
              routeBuilders: currentViewModel.getRoutesBuilders,
              initialRoute: route),
    );
  }

  HomeTabBarViewModel get currentViewModel {
    return viewModel as HomeTabBarViewModel;
  }
}
