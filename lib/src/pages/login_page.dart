import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/application/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";
  BuildContext? _pageContext;
  LoginPageViewModel _loginPageViewModel = LoginPageViewModel();
  late LoginPageViewModel _delegate;

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
    _setDelegate(_loginPageViewModel);
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              children: [
                const SizedBox(height: 20),
                _getTitle(),
                const Divider(height: 40),
                _getForm()
              ],
            ))));
  }

  Widget _getTitle() {
    return const Center(
        child: Text(
      "Welcome! \n Access and start plogging!",
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    ));
  }

  Widget _getForm() {
    return Column(
      children: [
        _createInput("Email", "Your email account",
            const Icon(Icons.alternate_email), _setEmail),
        const SizedBox(height: 15),
        _createInput("Password", "Your password account",
            const Icon(Icons.lock_outline), _setPassword),
        const SizedBox(height: 20),
        _createButtonWithIcon(
            0, _submitForm, const Text("Login"), const Icon(Icons.login)),
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

  void _setEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  void _setPassword(String password) {
    setState(() {
      _password = password;
    });
  }

  void _setContext(BuildContext context) {
    setState(() {
      _pageContext = context;
    });
  }

  void _setDelegate(LoginPageViewModel delegate) {
    setState(() {
      _delegate = delegate;
    });
  }

  void _submitForm() {
    _loginPageViewModel.validateForm(_email, _password);
  }

  void _navigateToRegister() {
    Navigator.push(_pageContext!,
        MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
}
