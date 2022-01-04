import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class INavigationService {
  Future<dynamic> navigateTo(Route route);
  Future<dynamic> navigateAndReplaceTo(Route route);
  Future<dynamic> navigateToByName(String routeName);
  Future<dynamic> navigateAndReplaceToByName(String routeName);
  Widget? getRouteWidget(String routeName);
  void goBack();
}
