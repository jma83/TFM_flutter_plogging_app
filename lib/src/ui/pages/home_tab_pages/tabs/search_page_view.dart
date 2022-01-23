import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_user_prefab.dart';
import 'package:flutter_plogging/src/ui/components/input_search.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/search_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/search_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class SearchPageView extends HomePageWidget {
  const SearchPageView(SearchPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as SearchPageViewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel.addListener(() {}, [SearchNotifiers.updateSearchPage]);
        },
        builder: (context, SearchPageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("Search")),
              body: Column(
                children: [
                  InputSearch(
                      value: viewModel.searchValue,
                      placeholder: "Search users",
                      maxLength: 30,
                      onChange: (value) => viewModel.setSearchValue(value),
                      onSubmit: (value) =>
                          viewModel.submitSearch(value, false)),
                  viewModel.users.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            const SizedBox(height: 5),
                            Text(viewModel.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500))
                          ],
                        ),
                  Expanded(
                      child: SizedBox(
                          height: 100.0,
                          child: viewModel.users.isNotEmpty
                              ? getSearchList()
                              : getEmptySearch()))
                ],
              ));
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
        itemCount: currentViewModel.users.length,
        itemBuilder: (BuildContext context, int index) {
          return CardUserPrefab(
              currentUserId: currentViewModel.currentUserId,
              handleFollowUser: currentViewModel.handleFollowUser,
              navigateToUser: currentViewModel.navigateToUser,
              index: index,
              user: currentViewModel.users[index]);
        });
  }

  SearchPageViewModel get currentViewModel {
    return viewModel as SearchPageViewModel;
  }
}
