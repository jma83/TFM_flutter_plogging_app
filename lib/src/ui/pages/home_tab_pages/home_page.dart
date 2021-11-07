import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_container.dart';
import 'package:flutter_plogging/src/ui/components/card_image_container.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_page_viewmodel.dart';

class HomePage extends StatelessWidget {
  HomePageViewModel homePageViewModel;
  HomePage(this.homePageViewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        CardContainer(cardType: 0, clickable: false),
        const SizedBox(height: 30),
        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(child: CardContainer(cardType: 1, clickable: true)),
          const SizedBox(width: 10),
          Expanded(child: CardImageContainer(cardType: 1, clickable: true))
        ])
      ],
    );
  }
}
