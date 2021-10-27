import 'package:flutter_plogging/src/ui/pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainRouteCoordinator extends ParentRouteCoordinator {
  MainRouteCoordinator(HomeTabBar mainWidget, navigationService)
      : super(mainWidget, navigationService);

  returnToPrevious() {
    navigationService.goBack();
  }
}
