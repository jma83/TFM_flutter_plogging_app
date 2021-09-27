// ignore_for_file: constant_identifier_names

class Ruta {
  final String _value;
  const Ruta._internal(this._value);
  getValue() => _value;

  static const Start = Ruta._internal('/');
  static const Login = Ruta._internal('login');
  static const Register = Ruta._internal('register');
  static const Home = Ruta._internal('home');
}
