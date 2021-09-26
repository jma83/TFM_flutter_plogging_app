import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Gender { NotDefined, Female, Male }

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  int _age = 0;
  Gender _gender = Gender.NotDefined;
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
        _createInput("Email", "Type your email",
            const Icon(Icons.alternate_email), _setEmail,
            emailField: true),
        _createInput("Username", "Type your username",
            const Icon(Icons.alternate_email), _setUsername),
        _createInput("Password", "Type your password",
            const Icon(Icons.lock_outline), _setPassword,
            passwordField: true),
        _createInput("Confirm password", "Confirm your password",
            const Icon(Icons.lock_outline), _setConfirmPassword,
            passwordField: true),
        _createInput(
            "Age", "Type your age", const Icon(Icons.date_range), _setAge),
        _createInput("Gender", "Type your age", const Icon(Icons.date_range),
            _setGender),
        _createButtonWithIcon(
            0, _submitForm, const Text("Login"), const Icon(Icons.login)),
      ],
    );
  }

  Widget _createInput(String label, String hint, Icon icon, Function onChange,
      {bool emailField = false,
      bool passwordField = false,
      bool numericField = false,
      bool dateField = false}) {
    final keyboardType = emailField
        ? TextInputType.emailAddress
        : numericField
            ? TextInputType.number
            : dateField
                ? TextInputType.datetime
                : TextInputType.name;
    return Stack(children: [
      TextField(
          maxLength: 50,
          obscureText: passwordField,
          keyboardType: keyboardType,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: label,
              hintText: hint,
              suffixIcon: icon),
          onChanged: (value) => onChange(value)),
      const SizedBox(height: 15)
    ]);
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

  void _setEmail(String email) => setState(() => _email = email);
  void _setUsername(String username) => setState(() => _username = username);
  void _setPassword(String password) => setState(() => _password = password);
  void _setConfirmPassword(String confirmPassword) =>
      setState(() => _confirmPassword = confirmPassword);
  void _setAge(int age) => setState(() => _age = age);
  void _setGender(Gender gender) => setState(() => _gender = gender);

  void _setContext(BuildContext context) {
    setState(() {
      _pageContext = context;
    });
  }

  void _submitForm() {}

  void _navigateToHome() {
    Navigator.push(_pageContext!,
        MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
}
