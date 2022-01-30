import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/components/empty_results_indicator.dart';
import 'package:flutter_plogging/src/ui/components/input_search.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/my_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/my_routes_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MyRoutesPageView extends HomePageWidget {
  const MyRoutesPageView(MyRoutesPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyRoutesPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as MyRoutesPageViewModel,
        onModelReady: (viewModel) {
          viewModel.submitSearch(viewModel.searchValue);
          viewModel.addListener(() {}, [MyRouteNotifiers.updateMyRoutesPage]);
          return;
        },
        builder: (context, MyRoutesPageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("My Routes")),
              body: Column(
                children: [
                  InputSearch(
                      value: viewModel.searchValue,
                      placeholder: "Search route names",
                      maxLength: 30,
                      onChange: (value) => viewModel.setSearchValue(value),
                      onSubmit: (value) => viewModel.submitSearch(value)),
                  Expanded(
                      child: SizedBox(
                          height: 100.0,
                          child: viewModel.routes.isNotEmpty
                              ? getSearchList()
                              : getEmptySearch()))
                ],
              ));
        });
  }

  getEmptySearch() {
    return const Center(
      child: EmptyResultsIndicator(
        text: "Couldn't find any route\nStart creating one now!",
      ),
    );
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
                id: currentViewModel.currentUser.id,
                authorUsername: currentViewModel.currentUser.username,
                index: index,
                route: currentViewModel.routes[index].routeListData,
                likeCallback: currentViewModel.likeRoute,
                navigateRouteCallback: currentViewModel.navigateToRoute,
              ));
        });
  }

  MyRoutesPageViewModel get currentViewModel {
    return viewModel as MyRoutesPageViewModel;
  }
}
