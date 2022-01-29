// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_container.dart';
import 'package:flutter_plogging/src/ui/components/card_image_container.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/home_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends HomePageWidget {
  const HomePageView(HomePageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => viewModel as HomePageViewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel.addListener(() {}, [HomeNotifiers.updateHomePage]);
        },
        builder: (context, HomePageViewModel viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Plogging challenge")),
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
      padding: const EdgeInsets.all(10),
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
          "No routes found in your feed...\nBy following users, routes will appear here",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }

  List<Widget> getHeaderWidgets() {
    return <Widget>[
      CardContainer(
          title: "Welcome ${currentViewModel.username}!\n" +
              "You and the community are helping while doing sport.\n" +
              "Keep on the good actions!",
          button1: "How it works",
          button2: "Start plogging",
          cardType: 0,
          callback1: () => currentViewModel.navigateToHowItWorks(),
          callback2: () => currentViewModel.redirectToPlogging(),
          clickable: true),
      const SizedBox(height: 15),
      CardImageContainer(
        cardType: 1,
        clickable: true,
        callback: () => currentViewModel.redirectToProfile(),
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
                  children: [
                    getWrapHeader(viewModel),
                    getTitle(),
                    card(viewModel, index)
                  ],
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
            id: viewModel.routesWithAuthor[index].routeListData.id!,
            route: viewModel.routesWithAuthor[index].routeListData,
            authorUsername: viewModel.routesWithAuthor[index].userData.username,
            likeCallback: viewModel.likeRoute,
            navigateRouteCallback: viewModel.navigateToRoute));
  }

  Widget getTitle() {
    return Container(
        margin: const EdgeInsets.only(left: 8),
        child: const Text("Routes feed:", style: TextStyle(fontSize: 18)));
  }

  HomePageViewModel get currentViewModel {
    return viewModel as HomePageViewModel;
  }
}
