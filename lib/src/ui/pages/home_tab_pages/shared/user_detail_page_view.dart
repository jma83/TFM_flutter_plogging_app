import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_header_user_detail.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/components/detail_content_container.dart';
import 'package:flutter_plogging/src/ui/components/top_navigation_bar.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/user_detail_page_view_model.dart';
import 'package:stacked/stacked.dart';

final List<int> colorCodes = <int>[500, 400, 700, 300, 600];

class UserDetailPageView extends HomePageWidget {
  const UserDetailPageView(UserDetailPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDetailPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as UserDetailPageViewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel.addListener(() {}, [UserDetailNotifier.updatePage]);
        },
        builder: (context, UserDetailPageViewModel viewModel, child) {
          return Scaffold(
              appBar: TopNavigationBar.getTopNavigationBar(
                  title: "User detail",
                  isBackVisible: true,
                  goBackCallback: viewModel.navigateToPrevious),
              body: DetailContentContainer(getRouteList(context)));
        });
  }

  getListViewHeader(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [getWrapHeader(context)],
    );
  }

  Widget getWrapHeader(BuildContext context) {
    return CardHeaderUserDetail(
      user: currentViewModel.user,
      creationDate: currentViewModel.formattedCreationDate,
      genderFormatted: currentViewModel.formattedGender,
      followUserCallback: currentViewModel.followUser,
      isSelf: false,
      hideFollow: currentViewModel.user.id == currentViewModel.currentUserId,
    );
  }

  getRouteList(BuildContext context) {
    return currentViewModel.userRoutes.isEmpty
        ? getListViewHeader(context)
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: currentViewModel.userRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getWrapHeader(context),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 15),
                      child: const Text(
                        "Routes:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    card(currentViewModel, index)
                  ],
                );
              }
              return card(currentViewModel, index);
            });
  }

  card(UserDetailPageViewModel viewModel, int index) {
    return Container(
        margin: index != 0 ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
        child: CardRoutePrefab(
            id: viewModel.user.id,
            authorUsername: viewModel.user.username,
            index: index,
            likeCallback: viewModel.likeRoute,
            navigateRouteCallback: viewModel.navigateToRoute,
            route: viewModel.userRoutes[index]));
  }

  UserDetailPageViewModel get currentViewModel {
    return viewModel as UserDetailPageViewModel;
  }
}
