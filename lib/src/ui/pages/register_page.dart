import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/di/injection.config.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/input_dropdown.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/components/button.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterPageViewModel>.reactive(
        viewModelBuilder: () => getIt<RegisterPageViewModel>(),
        onModelReady: (viewModel) => viewModel.addListener(
            () => showErrorAlert(context, viewModel), ["invalid_register"]),
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
    return Column(
      children: [
        InputText.createInput("Email", "Type your email",
            const Icon(Icons.alternate_email), 50, viewModel.setEmail,
            emailField: true, bottomHeight: 10),
        InputText.createInput("Username", "Type your username",
            const Icon(Icons.person_outline), 25, viewModel.setUsername,
            bottomHeight: 10),
        InputText.createInput("Password", "Type your password",
            const Icon(Icons.lock_outline), 25, viewModel.setPassword,
            passwordField: true, bottomHeight: 10),
        InputText.createInput("Confirm password", "Confirm your password",
            const Icon(Icons.lock_outline), 25, viewModel.setConfirmPassword,
            passwordField: true, bottomHeight: 10),
        InputText.createInput("Age", "Type your age",
            const Icon(Icons.date_range), 3, viewModel.setAge,
            bottomHeight: 10, numericField: true),
        InputDropdown(
            viewModel.gender,
            const [Gender.NotDefined, Gender.Female, Gender.Male],
            const Icon(Icons.all_inclusive_sharp),
            viewModel.setGender),
        Button.createButtonWithIcon(0, viewModel.validateForm,
            const Text("Register"), const Icon(Icons.login)),
      ],
    );
  }

  showErrorAlert(BuildContext context, RegisterPageViewModel viewModel) {
    showDialog(
        context: context,
        builder: (_) => Alert.createInfoAlert(
            "Error", viewModel.errorMessage, viewModel.dismissAlert));
  }
}
