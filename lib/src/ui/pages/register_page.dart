import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/profile_form_fields.dart';
import 'package:flutter_plogging/src/ui/pages/page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends PageWidget {
  @override
  const RegisterPage(RegisterPageViewModel viewModel, {Key? key})
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
                    children: [
                      const SizedBox(height: 20),
                      _getTitle(),
                      const Divider(height: 40),
                      _getForm(viewModel)
                    ],
                  ))));
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
