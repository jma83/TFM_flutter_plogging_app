import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/utils/alert_utils.dart';
import 'package:flutter_plogging/src/ui/components/form_container.dart';
import 'package:flutter_plogging/src/ui/notifiers/login_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:flutter_plogging/src/utils/text_widget_utils.dart';
import 'package:stacked/stacked.dart';

class LoginPageView extends PageWidget {
  const LoginPageView(LoginPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as LoginPageViewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(() => showErrorAlert(context, viewModel),
              [LoginNotifiers.loginProcessError]);
          viewModel.toggleLoading();
        },
        builder: (context, LoginPageViewModel viewModel, child) {
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
    return Center(
        child: Text(
      "Welcome! \n Access and start plogging!",
      style: TextWidgetUtils.getTitleStyleText(fontSize: 24),
      textAlign: TextAlign.center,
    ));
  }

  Widget _getForm(LoginPageViewModel viewModel) {
    return Column(
      children: [
        InputText(
            textController: TextEditingController(text: viewModel.email),
            label: "Email",
            hint: "Your account email",
            icon: const Icon(Icons.alternate_email),
            maxLength: 0,
            onChange: viewModel.setEmail),
        const SizedBox(height: 15),
        InputText(
            textController: TextEditingController(text: viewModel.password),
            label: "Password",
            hint: "Your account password",
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
        builder: (_) => AlertUtils.createInfoAlert(
            "Error", viewModel.errorMessage, viewModel.dismissAlert));
  }
}
