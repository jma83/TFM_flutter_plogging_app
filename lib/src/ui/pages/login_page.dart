import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  final LoginPageViewModel viewModel;
  const LoginPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) => viewModel.addListener(
            () => showErrorAlert(context, viewModel), ["error_signin"]),
        builder: (context, LoginPageViewModel viewModel, child) {
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
      "Welcome! \n Access and start plogging!",
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    ));
  }

  Widget _getForm(LoginPageViewModel viewModel) {
    return Column(
      children: [
        InputText(
            label: "Email",
            hint: "Your email account",
            icon: const Icon(Icons.alternate_email),
            maxLength: 0,
            onChange: viewModel.setEmail),
        const SizedBox(height: 15),
        InputText(
            label: "Password",
            hint: "Your password account",
            icon: const Icon(Icons.lock_outline),
            maxLength: 0,
            onChange: viewModel.setPassword,
            isPasswordField: true),
        const SizedBox(height: 20),
        InputButton(
            label: const Text("Login"),
            buttonType: InputButtonType.elevated,
            onPress: viewModel.validateForm,
            icon: const Icon(Icons.login)),
        const SizedBox(height: 15),
        InputButton(
            label: const Text("Register"),
            buttonType: InputButtonType.outlined,
            onPress: viewModel.manageRegisterNavigation,
            icon: const Icon(Icons.person_add))
      ],
    );
  }

  showErrorAlert(BuildContext context, LoginPageViewModel viewModel) {
    showDialog(
        context: context,
        builder: (_) => Alert.createInfoAlert(
            "Error", viewModel.errorMessage, viewModel.dismissAlert));
  }
}
