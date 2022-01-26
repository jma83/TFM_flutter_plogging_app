import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/form_container.dart';
import 'package:flutter_plogging/src/ui/components/profile_form_fields.dart';
import 'package:flutter_plogging/src/ui/pages/page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegisterPageView extends PageWidget {
  @override
  const RegisterPageView(RegisterPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as RegisterPageViewModel,
        onModelReady: (viewModel) => viewModel.addListener(
            () => showErrorAlert(context, viewModel), ["error_signup"]),
        builder: (context, RegisterPageViewModel viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Plogging Challenge")),
            body: FormContainer(widgetList: [
              const SizedBox(height: 20),
              _getTitle(),
              const Divider(height: 40),
              _getForm(viewModel)
            ]),
          );
        });
  }

  Widget _getTitle() {
    return const Center(
        child: Text(
      "Sign up now!",
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    ));
  }

  Widget _getForm(RegisterPageViewModel viewModel) {
    return ProfileFormFields(
        email: viewModel.email,
        age: viewModel.age,
        gender: viewModel.gender,
        username: viewModel.username,
        password: viewModel.password,
        confirmPassword: viewModel.confirmPassword,
        callbackValidateForm: viewModel.validateForm,
        isRegister: true,
        callbackSetAge: viewModel.setAge,
        callbackSetPassword: viewModel.setPassword,
        callbackSetConfirmPassword: viewModel.setConfirmPassword,
        callbackSetEmail: viewModel.setEmail,
        callbackSetGender: viewModel.setGender,
        callbackSetUsername: viewModel.setUsername);
  }

  showErrorAlert(BuildContext context, RegisterPageViewModel viewModel) {
    showDialog(
        context: context,
        builder: (_) => Alert.createInfoAlert(
            "Error", viewModel.errorMessage, viewModel.dismissAlert));
  }
}
