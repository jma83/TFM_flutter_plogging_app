import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageRouteCoordinator extends ParentRouteCoordinator {
  final NavigationService _navigationService;
  StartPageRouteCoordinator(this._navigationService);

  navigateToLogin() {
    final route = routeBuild(const LoginPage());
    _navigationService.navigateAndReplaceTo(route);
  }
}
