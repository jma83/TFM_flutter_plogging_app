import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_route.dart';
import 'package:flutter_plogging/src/ui/notifiers/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/user_detail_page_view_model.dart';
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
                      child: InkWell(
                        child: ListView(
                          children: [
                            Text(
                              viewModel.user.username,
                              style: TextStyle(fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ))),
          );
        });
  }

  card(UserDetailPageViewModel viewModel, int index) {
    return Container(
        margin: index != 0 ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
        child: CardRoute(
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
