import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/detail_content_container.dart';
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
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Image(image: AssetImage("assets/logo.png"), width: 150),
        SizedBox(height: 12),
        Text(
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas , las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.   ",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
