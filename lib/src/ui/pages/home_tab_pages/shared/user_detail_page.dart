import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_header_user_detail.dart';
import 'package:flutter_plogging/src/ui/components/card_route_prefab.dart';
import 'package:flutter_plogging/src/ui/components/detail_content_container.dart';
import 'package:flutter_plogging/src/ui/components/top_navigation_bar.dart';
import 'package:flutter_plogging/src/ui/notifiers/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/user_detail_page_view_model.dart';
import 'package:stacked/stacked.dart';

final List<int> colorCodes = <int>[500, 400, 700, 300, 600];

class UserDetailPage extends StatelessWidget {
  final UserDetailPageViewModel viewModel;
  const UserDetailPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDetailPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
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
      user: viewModel.user,
      creationDate: viewModel.formattedCreationDate,
      genderFormatted: viewModel.formattedGender,
      followUserCallback: viewModel.followUser,
      isSelf: false,
      hideFollow: viewModel.user.id == viewModel.currentUserId,
    );
  }

  getRouteList(BuildContext context) {
    return viewModel.userRoutes.isEmpty
        ? getListViewHeader(context)
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: viewModel.userRoutes.length,
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
                    card(viewModel, index)
                  ],
                );
              }
              return card(viewModel, index);
            });
  }

  card(UserDetailPageViewModel viewModel, int index) {
    return Container(
        margin: index != 0 ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
        child: CardRoutePrefab(
            authorUsername: viewModel.user.username,
            index: index,
            likeCallback: viewModel.likeRoute,
            navigateRouteCallback: viewModel.navigateToRoute,
            route: viewModel.userRoutes[index]));
  }
}
