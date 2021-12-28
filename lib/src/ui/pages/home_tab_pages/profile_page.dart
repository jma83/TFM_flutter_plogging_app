import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/card_header_user_detail.dart';
import 'package:flutter_plogging/src/ui/notifiers/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/profile_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  final ProfilePageViewModel viewModel;
  const ProfilePage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(() {}, [ProfileNotifiers.updateProfilePage]);
        },
        builder: (context, ProfilePageViewModel viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Profile")),
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
                      child: InkWell(child: getListViewHeader(context)),
                    ))),
          );
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
      isSelf: true,
    );
  }
}
