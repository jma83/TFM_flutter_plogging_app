import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_container.dart';
import 'package:flutter_plogging/src/ui/components/card_image_container.dart';
import 'package:flutter_plogging/src/ui/components/card_route.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  final List<int> colorCodes = <int>[500, 400, 700, 300, 600];

  HomePageViewModel viewModel;
  HomePage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel.addListener(() {}, [HomeNotifiers.updateHomePage]);
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
      children: getHeaderWidgets(),
    );
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
    return viewModel.routes.isEmpty
        ? getListViewHeader(viewModel)
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: viewModel.routes.length,
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
        child: CardRoute(
          color: Colors.green[colorCodes[index % 5]],
          height: 130,
          image: viewModel.routes[index].image,
          name: viewModel.routes[index].name!,
          description: viewModel.routes[index].description ?? "",
          authorName: viewModel.currentUser.username,
          date: viewModel.getDateFormat(viewModel.routes[index]),
          callback: () => viewModel.navigateToRoute(viewModel.routes[index]),
          callbackLike: () => viewModel.likeRoute(viewModel.routes[index]),
          isLiked: viewModel.routes[index].isLiked,
        ));
  }
}
