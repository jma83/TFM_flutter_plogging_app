import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/input_dropdown.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends StatelessWidget {
  final RegisterPageViewModel viewModel;
  const RegisterPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
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
    return Column(
      children: [
        InputText(
          inputType: TextInputType.emailAddress,
          bottomHeight: 10,
          label: "Email",
          hint: "Type your email",
          icon: const Icon(Icons.alternate_email),
          maxLength: 50,
          onChange: viewModel.setEmail,
        ),
        InputText(
          inputType: TextInputType.emailAddress,
          label: "Username",
          hint: "Type your username",
          icon: const Icon(Icons.person_outline),
          maxLength: 25,
          onChange: viewModel.setUsername,
          bottomHeight: 10,
        ),
        InputText(
            label: "Password",
            hint: "Type your password",
            icon: const Icon(Icons.lock_outline),
            maxLength: 25,
            onChange: viewModel.setPassword,
            isPasswordField: true,
            bottomHeight: 10),
        InputText(
            label: "Confirm password",
            hint: "Confirm your password",
            icon: const Icon(Icons.lock_outline),
            maxLength: 25,
            onChange: viewModel.setConfirmPassword,
            isPasswordField: true,
            bottomHeight: 10),
        InputText(
          label: "Age",
          hint: "Type your age",
          icon: const Icon(Icons.date_range),
          maxLength: 3,
          onChange: viewModel.setAge,
          inputType: TextInputType.number,
          bottomHeight: 10,
        ),
        InputDropdown(
            viewModel.gender,
            const [Gender.NotDefined, Gender.Female, Gender.Male],
            const Icon(Icons.all_inclusive_sharp),
            viewModel.setGender),
        InputButton(
            label: const Text("Register"),
            buttonType: InputButtonType.elevated,
            onPress: viewModel.validateForm,
            icon: const Icon(Icons.login)),
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
