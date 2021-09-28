import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginPageRouteCoordinator extends ParentRouteCoordinator {
  final NavigationService _navigationService;
  LoginPageRouteCoordinator(this._navigationService);

  navigateToRegister() {
    final route = routeBuild(const RegisterPage());
    _navigationService.navigateTo(route);
  }

  navigateToHome() {
    final route = routeBuild(const HomePage());
    _navigationService.navigateAndReplaceTo(route);
  }

  returnToPrevious() {
    _navigationService.goBack();
  }
}
