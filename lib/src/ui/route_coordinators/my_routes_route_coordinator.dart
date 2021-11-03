import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyRoutesRouteCoordinator extends ParentRouteCoordinator {
  MyRoutesRouteCoordinator(
      MyRoutesPage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService);
}
