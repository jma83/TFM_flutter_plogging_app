import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/view_models/login_page/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/injection.config.dart';
import 'package:flutter_plogging/src/ui/components/button.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:flutter_plogging/src/ui/pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginPageViewModel>.reactive(
        viewModelBuilder: () => getIt<LoginPageViewModel>(),
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
        InputText.createInput("Email", "Your email account",
            const Icon(Icons.alternate_email), viewModel.setEmail),
        const SizedBox(height: 15),
        InputText.createInput("Password", "Your password account",
            const Icon(Icons.lock_outline), viewModel.setPassword),
        const SizedBox(height: 20),
        Button.createButtonWithIcon(0, viewModel.validateForm,
            const Text("Login"), const Icon(Icons.login)),
        const SizedBox(height: 15),
        Button.createButtonWithIcon(1, viewModel.manageRegisterNavigation,
            const Text("Register"), const Icon(Icons.person_add))
      ],
    );
  }
}
