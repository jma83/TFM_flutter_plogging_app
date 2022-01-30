import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/shared/input_button.dart';
import 'package:flutter_plogging/src/ui/components/user/card_header_user_detail.dart';
import 'package:flutter_plogging/src/ui/components/user/card_progress_user.dart';
import 'package:flutter_plogging/src/utils/alert_utils.dart';
import 'package:flutter_plogging/src/ui/components/shared/detail_content_container.dart';
import 'package:flutter_plogging/src/ui/components/shared/upload_image.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/profile_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfilePageView extends HomePageWidget {
  const ProfilePageView(ProfilePageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
        viewModelBuilder: () => viewModel as ProfilePageViewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(() {}, [ProfileNotifiers.updateProfilePage]);
          viewModel.addListener(() => showConfirmationLogoutModal(context),
              [ProfileNotifiers.showLogoutConfirmation]);
          viewModel.addListener(() => showUploadImageModal(context),
              [ProfileNotifiers.showUploadImage]);
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
    return ListView(padding: const EdgeInsets.all(8), children: [
      getWrapHeader(context),
      CardProgressUser(
          value: currentViewModel.objectiveProgress,
          redirectCallback: currentViewModel.redirectToPlogging)
    ]);
  }

  Widget getWrapHeader(BuildContext context) {
    return currentViewModel.user == null
        ? Container()
        : CardHeaderUserDetail(
            user: currentViewModel.user!,
            creationDate: currentViewModel.formattedCreationDate,
            genderFormatted: currentViewModel.formattedGender,
            isSelf: true,
            editUserCallback: currentViewModel.navigateToEdit,
            likedRoutesCallback: currentViewModel.navigateToLikedRoutes,
            changeImageCallback: currentViewModel.onClickImage,
            xp: currentViewModel.user!.xp,
            maxXp: currentViewModel.maxXp,
          );
  }

  Widget getLoggoutFloatingButton() {
    return InputButton(
      bgColor: Colors.red[400],
      onPress: currentViewModel.logout,
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
        builder: (_) => AlertUtils.createOptionsAlert(
            "Logout confirmation",
            "Do you want to close your current session?",
            () => currentViewModel.confirmLogoutProfile(),
            () => currentViewModel.dismissAlert()));
  }

  showUploadImageModal(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertUtils.createCustomOptionsAlert(
            "Upload profile image",
            UploadImage(
              image: currentViewModel.tmpImage,
              uploadImage: currentViewModel.uploadImage,
            ),
            currentViewModel.updateUserImage,
            currentViewModel.dismissAlert,
            height: 300));
  }

  ProfilePageViewModel get currentViewModel {
    return viewModel as ProfilePageViewModel;
  }
}
