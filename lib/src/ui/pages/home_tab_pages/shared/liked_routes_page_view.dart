import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/components/empty_results_indicator.dart';
import 'package:flutter_plogging/src/ui/components/top_navigation_bar.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/liked_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/liked_routes_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LikedRoutesPageView extends HomePageWidget {
  const LikedRoutesPageView(LikedRoutesPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LikedRoutesPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as LikedRoutesPageViewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel
              .addListener(() {}, [LikedRoutesNotifiers.updateLikedRoutesPage]);
          return;
        },
        builder: (context, LikedRoutesPageViewModel viewModel, child) {
          return Scaffold(
              appBar: TopNavigationBar.getTopNavigationBar(
                  title: "My liked routes",
                  isBackVisible: true,
                  goBackCallback: viewModel.navigateToPrevious),
              body: viewModel.routes.isNotEmpty
                  ? getSearchList()
                  : getEmptySearch());
        });
  }

  getEmptySearch() {
    return const Center(
        child: EmptyResultsIndicator(
      text: "Couldn't find any route\nYour liked routes will appear here!",
    ));
  }

  getSearchList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: currentViewModel.routes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin:
                  index != 0 ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
              child: CardRoutePrefab(
                id: currentViewModel.routes[index].routeListData.id!,
                authorUsername:
                    currentViewModel.routes[index].userData.username,
                index: index,
                route: currentViewModel.routes[index].routeListData,
                likeCallback: currentViewModel.likeRoute,
                navigateRouteCallback: currentViewModel.navigateToRoute,
              ));
        });
  }

  LikedRoutesPageViewModel get currentViewModel {
    return viewModel as LikedRoutesPageViewModel;
  }
}
