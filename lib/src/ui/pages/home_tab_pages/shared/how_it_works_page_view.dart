import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/detail_content_container.dart';
import 'package:flutter_plogging/src/ui/components/text_link.dart';
import 'package:flutter_plogging/src/ui/components/top_navigation_bar.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/how_it_works_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class HowItWorksPageView extends HomePageWidget {
  const HowItWorksPageView(HowItWorksPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HowItWorksPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as HowItWorksPageViewModel,
        builder: (context, HowItWorksPageViewModel viewModel, child) {
          return Scaffold(
              appBar: TopNavigationBar.getTopNavigationBar(
                  title: "How it works",
                  isBackVisible: true,
                  goBackCallback: viewModel.navigateToPrevious),
              body: DetailContentContainer(getContent(context)));
        });
  }

  Widget getContent(BuildContext context) {
    return ListView(children: [
      Center(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Image(image: AssetImage("assets/logo.png"), width: 120),
                    Text(
                      "Plogging challenge",
                      style: TextStyle(fontSize: 28),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "The aim of this application is to promote the Plogging activity. \n\nPlogging is a combination of jogging with picking up litter. By doing sport, we can contribute to clean enviroments around the cities. \n\nIn this app, you can record your routes when doing Plogging and share it with other users of the platform",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text('For more info about plogging, checkout this site: '),
                    TextLink(
                        label: 'Plogging.org',
                        link: 'https://www.plogging.org/what-is-plogging')
                  ])))
    ]);
  }
}
