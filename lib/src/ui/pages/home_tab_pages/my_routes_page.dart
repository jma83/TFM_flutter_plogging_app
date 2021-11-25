import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_search.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/my_routes_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MyRoutesPage extends StatelessWidget {
  final List<int> colorCodes = <int>[600, 500, 100, 200];
  MyRoutesPageViewModel viewModel;
  MyRoutesPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyRoutesPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.submitSearch(viewModel.searchValue);
          if (!viewModel.hasListeners) {
            viewModel.addListener(() {}, ["update_my_routes"]);
            return;
          }
        },
        builder: (context, MyRoutesPageViewModel viewModel, child) {
          return Column(
            children: [
              InputSearch(
                  value: viewModel.searchValue,
                  placeholder: "Search Routes",
                  maxLength: 30,
                  onChange: (value) => viewModel.setSearchValue(value),
                  onSubmit: (value) => viewModel.submitSearch(value)),
              Expanded(
                  child: SizedBox(
                      height: 100.0,
                      child: viewModel.routes.isNotEmpty
                          ? getSearchList()
                          : getEmptySearch()))
            ],
          );
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
          "Empty results",
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
            height: 50,
            color: Colors.amber[colorCodes[index % 3]],
            child: Center(child: Text('Entry ${viewModel.routes[index].name}')),
          );
        });
  }
}
