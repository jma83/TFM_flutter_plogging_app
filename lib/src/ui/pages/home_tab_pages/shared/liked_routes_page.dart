import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/notifiers/liked_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/liked_routes_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LikedRoutesPage extends StatelessWidget {
  final List<int> colorCodes = <int>[500, 400, 700, 300, 600];
  final LikedRoutesPageViewModel viewModel;
  LikedRoutesPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LikedRoutesPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel
              .addListener(() {}, [LikedRoutesNotifiers.updateLikedRoutesPage]);
          return;
        },
        builder: (context, LikedRoutesPageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("My liked routes")),
              body: viewModel.routes.isNotEmpty
                  ? getSearchList()
                  : getEmptySearch());
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
          "Couldn't find any route\nYour liked routes will appear here!",
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
                authorUsername: viewModel.routes[index].userData.username,
                index: index,
                route: viewModel.routes[index].routeListData,
                likeCallback: viewModel.likeRoute,
                navigateRouteCallback: viewModel.navigateToRoute,
              ));
        });
  }
}
