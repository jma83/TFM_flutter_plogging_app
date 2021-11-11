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
        onModelReady: (viewModel) => viewModel.findUserData(),
        builder: (context, HomePageViewModel viewModel, child) {
          return ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              CardContainer(
                  title: "Benvenuti ${viewModel.username}",
                  cardType: 0,
                  clickable: false),
              const SizedBox(height: 30),
              Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Expanded(
                    child: CardContainer(
                        title: "Benvenuti ${viewModel.username}",
                        cardType: 1,
                        clickable: true)),
                const SizedBox(width: 10),
                Expanded(
                    child: CardImageContainer(cardType: 1, clickable: true))
              ])
            ],
          );
        });
  }
}
