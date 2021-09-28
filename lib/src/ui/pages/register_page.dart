import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/view_models/register_page/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/injection.config.dart';
import 'package:flutter_plogging/src/ui/components/button.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterPageViewModel>.reactive(
        viewModelBuilder: () => getIt<RegisterPageViewModel>(),
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
            const Icon(Icons.alternate_email), viewModel.setEmail,
            emailField: true),
        InputText.createInput("Username", "Type your username",
            const Icon(Icons.person_outline), viewModel.setUsername),
        InputText.createInput("Password", "Type your password",
            const Icon(Icons.lock_outline), viewModel.setPassword,
            passwordField: true),
        InputText.createInput("Confirm password", "Confirm your password",
            const Icon(Icons.lock_outline), viewModel.setConfirmPassword,
            passwordField: true),
        InputText.createInput("Age", "Type your age",
            const Icon(Icons.date_range), viewModel.setAge),
        InputText.createInput("Gender", "Select your gender",
            const Icon(Icons.all_inclusive_sharp), viewModel.setGender),
        Button.createButtonWithIcon(0, () => viewModel.validateForm,
            const Text("Register"), const Icon(Icons.login)),
      ],
    );
  }
}
