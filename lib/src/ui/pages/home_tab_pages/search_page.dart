import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_container.dart';
import 'package:flutter_plogging/src/ui/components/input_search.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/search_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class SearchPage extends StatelessWidget {
  final SearchPageViewModel viewModel;
  SearchPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(() {}, ["update_search_page"]);
        },
        builder: (context, SearchPageViewModel viewModel, child) {
          return Column(
            children: [
              InputSearch(
                  value: viewModel.searchValue,
                  placeholder: "Search",
                  maxLength: 30,
                  onChange: (value) => viewModel.setSearchValue(value),
                  onSubmit: (value) => viewModel.submitSearch(value)),
              Expanded(
                  child: SizedBox(
                      height: 100.0,
                      child: viewModel.users.isNotEmpty
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
        itemCount: viewModel.users.length,
        itemBuilder: (BuildContext context, int index) {
          return CardContainer(
            title: viewModel.users[index].username,
            cardType: 1,
            clickable: true,
            button1: "Follow",
            callback: () {},
          );
        });
  }
}
