import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_route.dart';
import 'package:flutter_plogging/src/ui/notifiers/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/user_detail_page_view_model.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';
import 'package:stacked/stacked.dart';

final List<int> colorCodes = <int>[500, 400, 700, 300, 600];

class UserDetailPage extends StatelessWidget {
  UserDetailPageViewModel viewModel;
  UserDetailPage(this.viewModel, {Key? key}) : super(key: key);

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
            appBar: AppBar(title: const Text("User Detail")),
            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.green[300]!,
                    Colors.green,
                  ],
                )),
                width: MediaQuery.of(context).size.width,
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1)),
                      child: InkWell(child: getRouteList(viewModel, context)),
                    ))),
          );
        });
  }

  Widget getAvatar(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
        child: viewModel.user.image == null || viewModel.user.image == ""
            ? CardWidgetUtils.getImageFromAsset(avatar: true)
            : CardWidgetUtils.getImageFromNetwork(viewModel.user.image!,
                avatar: true));
  }

  Widget getUsername() {
    return Center(
        child: Text(
      viewModel.user.username,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    ));
  }

  Widget getUserLevel() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
            color: Colors.yellow[500],
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(20)),
        width: 100,
        child: Text(
          "- Level ${viewModel.user.level} -",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ));
  }

  Widget getFollowersCount(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Followers: ${viewModel.user.followers}",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 10),
          Text(
            "Following: ${viewModel.user.following}",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width / 2,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
      )
    ]);
  }

  Widget getUserDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Gender: ${viewModel.formattedGender}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 10),
        Text(
          "Age: ${viewModel.user.age}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 10),
        Text(
          "Creation date: ${viewModel.formattedCreationDate}",
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  getListViewHeader(BuildContext context) {
    ListView(
      padding: EdgeInsets.all(2),
      children: [getWrapHeader(context)],
    );
  }

  Widget getWrapHeader(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getAvatar(context),
            const SizedBox(
              height: 10,
            ),
            getUsername(),
            const SizedBox(
              height: 10,
            ),
            getUserLevel(),
            const SizedBox(
              height: 15,
            ),
            getFollowersCount(context),
            getUserDetails()
          ],
        ));
  }

  getRouteList(UserDetailPageViewModel viewModel, BuildContext context) {
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
                      margin:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                      child: Text(
                        "Rutas:",
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
        child: CardRoute(
          id: "$index",
          color: Colors.green[colorCodes[index % 5]],
          height: 130,
          image: viewModel.userRoutes[index].image,
          name: viewModel.userRoutes[index].name!,
          description: viewModel.userRoutes[index].description ?? "",
          authorName: viewModel.currentUser.username,
          date: viewModel.getDateFormat(viewModel.userRoutes[index]),
          callback: () =>
              viewModel.navigateToRoute(viewModel.userRoutes[index]),
          callbackLike: () => viewModel.likeRoute(viewModel.userRoutes[index]),
          isLiked: viewModel.userRoutes[index].isLiked,
        ));
  }
}
