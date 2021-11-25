import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_container.dart';
import 'package:flutter_plogging/src/ui/components/card_image_container.dart';
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
          viewModel.addListener(() {}, ["update_home_page"]);
        },
        builder: (context, HomePageViewModel viewModel, child) {
          return ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              CardContainer(
                  title: "Welcome ${viewModel.username}!\n" +
                      "You and the community are helping while doing sport.\n" +
                      "Keep on the good actions!",
                  button1: "How it works",
                  button2: "Start plogging",
                  cardType: 0,
                  callback: () {},
                  clickable: true),
              const SizedBox(height: 30),
              CardImageContainer(
                cardType: 3,
                clickable: true,
                text: "Start Plogging",
                height: 100,
              ),
              const SizedBox(height: 30),
              Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Expanded(
                    child: CardImageContainer(
                  cardType: 1,
                  clickable: true,
                  text: "Watch your today's progress",
                  height: 200,
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: CardImageContainer(
                  cardType: 1,
                  clickable: true,
                  text: "Dicover other people contributions!",
                  height: 200,
                ))
              ])
            ],
          );
        });
  }
}
