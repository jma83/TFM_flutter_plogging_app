import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/card_header_user_detail.dart';
import 'package:flutter_plogging/src/ui/components/detail_content_container.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/profile_page_viewmodel.dart';
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
          viewModel.addListener(() => showConfirmationLogoutModal(context),
              [ProfileNotifiers.showLogoutConfirmation]);
        },
        builder: (context, ProfilePageViewModel viewModel, child) {
          return Scaffold(
              floatingActionButton: getLoggoutFloatingButton(),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              appBar: AppBar(title: const Text("My Profile")),
              body: DetailContentContainer(getListViewHeader(context)));
        });
  }

  getListViewHeader(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [getWrapHeader(context)],
    );
  }

  Widget getWrapHeader(BuildContext context) {
    return viewModel.user == null
        ? Container()
        : CardHeaderUserDetail(
            user: viewModel.user!,
            creationDate: viewModel.formattedCreationDate,
            genderFormatted: viewModel.formattedGender,
            isSelf: true,
            editUserCallback: viewModel.navigateToEdit,
            likedRoutesCallback: viewModel.navigateToLikedRoutes,
            xp: viewModel.user!.xp);
  }

  Widget getLoggoutFloatingButton() {
    return InputButton(
      bgColor: Colors.red[400],
      onPress: viewModel.logout,
      width: 100,
      horizontalPadding: 12,
      label: Row(
        children: const [
          Icon(Icons.logout, size: 20),
          SizedBox(
            width: 5,
          ),
          Text("Logout")
        ],
      ),
    );
  }

  showConfirmationLogoutModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Alert.createOptionsAlert(
            "Logout confirmation",
            "Do you want to close your current session?",
            () => viewModel.confirmLogoutProfile(),
            () => viewModel.dismissAlert()));
  }
}
