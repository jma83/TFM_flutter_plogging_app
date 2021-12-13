import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/route_detail_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RouteDetailPage extends StatelessWidget {
  RouteDetailPageViewModel viewModel;
  RouteDetailPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteDetailPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) => {},
        builder: (context, RouteDetailPageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("Plogging Challenge")),
              body: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        InputText(
                            label: "Elpepe",
                            hint: "hint",
                            icon: Icon(Icons.ac_unit_outlined),
                            maxLength: 20,
                            onChange: () {})
                      ],
                    ),
                  )));
        });
  }
}
