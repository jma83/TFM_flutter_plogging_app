import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageRouteCoordinator {
  final NavigationService _navigationService;
  StartPageRouteCoordinator(this._navigationService);

  navigateToLogin() {
    final route = MaterialPageRoute(builder: (context) => const LoginPage());
    _navigationService.navigateAndReplaceTo(route);
  }
}
