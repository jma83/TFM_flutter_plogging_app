import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/form_container.dart';
import 'package:flutter_plogging/src/ui/components/profile_form_fields.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/edit_profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/edit_profile_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class EditProfilePageView extends HomePageWidget {
  const EditProfilePageView(EditProfilePageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfilePageViewModel>.reactive(
        viewModelBuilder: () => viewModel as EditProfilePageViewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(
              () => {}, [EditProfileNotifiers.updateEditProfilePage]);
          viewModel.loadPage();
          viewModel.addListener(() => showErrorAlert(context, viewModel),
              [EditProfileNotifiers.editProfileProcessError]);
          viewModel.addListener(
              () => showUpdateConfirmation(context, viewModel),
              [EditProfileNotifiers.updateProfileData]);
        },
        builder: (context, EditProfilePageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("Edit profile data")),
              body: FormContainer(widgetList: [_getForm(viewModel)]));
        });
  }

  Widget _getForm(EditProfilePageViewModel viewModel) {
    return ProfileFormFields(
        email: viewModel.email,
        username: viewModel.username,
        age: viewModel.age,
        gender: viewModel.gender,
        callbackValidateForm: viewModel.validateForm,
        isRegister: false,
        callbackSetAge: viewModel.setAge,
        callbackSetOldPassword: viewModel.setOldPassword,
        callbackSetPassword: viewModel.setPassword,
        callbackSetConfirmPassword: viewModel.setConfirmPassword,
        callbackSetEmail: viewModel.setEmail,
        callbackSetGender: viewModel.setGender,
        callbackSetUsername: viewModel.setUsername);
  }

  showErrorAlert(BuildContext context, EditProfilePageViewModel viewModel) {
    showDialog(
        context: context,
        builder: (_) => Alert.createInfoAlert(
            "Error", viewModel.errorMessage, viewModel.dismissAlert));
  }

  showUpdateConfirmation(
      BuildContext context, EditProfilePageViewModel viewModel) {
    showDialog(
        context: context,
        builder: (_) => Alert.createInfoAlert("Success",
            "Your data has been updated successfully", viewModel.dismissAlert));
  }
}
