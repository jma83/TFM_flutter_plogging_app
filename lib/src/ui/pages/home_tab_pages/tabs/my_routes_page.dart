import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/components/input_search.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/my_routes_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MyRoutesPage extends StatelessWidget {
  final List<int> colorCodes = <int>[500, 400, 700, 300, 600];
  MyRoutesPageViewModel viewModel;
  MyRoutesPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyRoutesPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.submitSearch(viewModel.searchValue);
          viewModel.addListener(() {}, ["update_my_routes"]);
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
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Image(image: AssetImage("assets/not-found.png"), width: 50),
        SizedBox(height: 12),
        Text(
          "Couldn't find any route\nStart creating one now!",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }

  getSearchList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: viewModel.routes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin:
                  index != 0 ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
              child: CardRoutePrefab(
                authorUsername: viewModel.currentUser.username,
                index: index,
                route: viewModel.routes[index].routeListData,
                likeCallback: viewModel.likeRoute,
                navigateRouteCallback: viewModel.navigateToRoute,
              ));
        });
  }
}
