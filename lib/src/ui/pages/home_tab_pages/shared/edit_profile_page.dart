import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/profile_form_fields.dart';
import 'package:flutter_plogging/src/ui/notifiers/edit_profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/edit_profile_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class EditProfilePage extends StatelessWidget {
  final EditProfilePageViewModel viewModel;
  const EditProfilePage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfilePageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(
              () => {}, [EditProfileNotifiers.updateEditProfilePage]);
          viewModel.loadPage();
          viewModel.addListener(() => showErrorAlert(context, viewModel),
              [EditProfileNotifiers.editProfileProcessError]);
        },
        builder: (context, EditProfilePageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("Edit profile data")),
              body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white38,
                      Colors.green,
                    ],
                  )),
                  child: Center(
                      child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    children: [_getForm(viewModel)],
                  ))));
        });
  }

  Widget _getForm(EditProfilePageViewModel viewModel) {
    return ProfileFormFields(
        email: viewModel.email,
        username: viewModel.username,
        age: viewModel.age,
        gender: viewModel.gender,
        callbackValidateForm: viewModel.validateForm,
        isRegister: true,
        callbackSetAge: viewModel.setAge,
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
}
