import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/login_page/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext? _pageContext;

  final _elevatedBtnStyle = OutlinedButton.styleFrom(
      side: const BorderSide(width: 1, color: Colors.grey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      fixedSize: const Size.fromWidth(200));

  @override
  Widget build(BuildContext context) {
    _setContext(context);
    return ViewModelBuilder<LoginPageViewModel>.reactive(
        viewModelBuilder: () => LoginPageViewModel(),
        builder: (context, LoginPageViewModel viewModel, child) => Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  children: [
                    const SizedBox(height: 20),
                    _getTitle(),
                    const Divider(height: 40),
                    _getForm(viewModel)
                  ],
                )))));
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
        _createInput("Email", "Your email account",
            const Icon(Icons.alternate_email), viewModel.setEmail),
        const SizedBox(height: 15),
        _createInput("Password", "Your password account",
            const Icon(Icons.lock_outline), viewModel.setPassword),
        const SizedBox(height: 20),
        _createButtonWithIcon(0, () => _submitForm(viewModel),
            const Text("Login"), const Icon(Icons.login)),
        const SizedBox(height: 15),
        _createButtonWithIcon(1, _navigateToRegister, const Text("Register"),
            const Icon(Icons.person_add))
      ],
    );
  }

  Widget _createInput(String label, String hint, Icon icon, Function onChange) {
    return TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: label,
            hintText: hint,
            suffixIcon: icon),
        onChanged: (value) => onChange(value));
  }

  Widget _createButtonWithIcon(
      int buttonType, final onPress, Widget label, Icon icon) {
    if (buttonType == 1) {
      return OutlinedButton.icon(
          onPressed: onPress,
          icon: icon,
          label: label,
          style: _elevatedBtnStyle);
    }
    return ElevatedButton.icon(
        onPressed: onPress, icon: icon, label: label, style: _elevatedBtnStyle);
  }

  void _setContext(BuildContext context) {
    setState(() {
      _pageContext = context;
    });
  }

  void _submitForm(LoginPageViewModel viewModel) {
    viewModel.addListener(_navigateToHome);
    viewModel.validateForm();
  }

  void _navigateToRegister() {
    Navigator.push(_pageContext!,
        MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void _navigateToHome() {
    print("notified!!!");
    Navigator.push(_pageContext!,
        MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
