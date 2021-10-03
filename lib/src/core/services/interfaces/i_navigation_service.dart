import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class INavigationService {
  Future<dynamic> navigateTo(Route route);
  Future<dynamic> navigateAndReplaceTo(Route route);
  void goBack();
}
