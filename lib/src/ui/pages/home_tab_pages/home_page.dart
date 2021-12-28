import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_container.dart';
import 'package:flutter_plogging/src/ui/components/card_image_container.dart';
import 'package:flutter_plogging/src/ui/components/card_route.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  HomePageViewModel viewModel;
  HomePage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel.addListener(() {
            print("heeeyye");
          }, [HomeNotifiers.updateHomePage]);
        },
        builder: (context, HomePageViewModel viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Home")),
            body: getRouteList(viewModel),
          );
        });
  }

  getWrapHeader(HomePageViewModel viewModel) {
    return Wrap(
      spacing: 10,
      children: getHeaderWidgets(),
    );
  }

  getListViewHeader(HomePageViewModel viewModel) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [...getHeaderWidgets(), getEmptySearch()],
    );
  }

  getEmptySearch() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(height: 20),
        Image(image: AssetImage("assets/not-found.png"), width: 40),
        SizedBox(height: 8),
        Text(
          "No routes found...\nBy following users, routes will appear here",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }

  List<Widget> getHeaderWidgets() {
    return <Widget>[
      CardContainer(
          title: "Welcome ${viewModel.username}!\n" +
              "You and the community are helping while doing sport.\n" +
              "Keep on the good actions!",
          button1: "How it works",
          button2: "Start plogging",
          cardType: 0,
          callback: () {},
          clickable: true),
      const SizedBox(height: 15),
      CardImageContainer(
        cardType: 1,
        clickable: true,
        text: "Watch your today's progress",
        height: 100,
      ),
      const SizedBox(height: 30)
    ];
  }

  getRouteList(HomePageViewModel viewModel) {
    return viewModel.routesWithAuthor.isEmpty
        ? getListViewHeader(viewModel)
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: viewModel.routesWithAuthor.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  children: [getWrapHeader(viewModel), card(viewModel, index)],
                );
              }
              return card(viewModel, index);
            });
  }

  card(HomePageViewModel viewModel, int index) {
    return Container(
        margin: index != 0 ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
        child: CardRoutePrefab(
            index: index,
            route: viewModel.routesWithAuthor[index].routeListData,
            authorUsername: viewModel.routesWithAuthor[index].userData.username,
            likeCallback: viewModel.likeRoute,
            navigateRouteCallback: viewModel.navigateToRoute));
  }
}
