import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterPageRouteCoordinator extends ParentRouteCoordinator {
  final NavigationService _navigationService;
  RegisterPageRouteCoordinator(this._navigationService);

  navigateToHome() {
    final route = routeBuild(const HomePage());
    _navigationService.navigateAndReplaceTo(route);
  }

  returnToLogin() {
    _navigationService.goBack();
  }
}
