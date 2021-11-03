import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileRouteCoordinator extends ParentRouteCoordinator {
  ProfileRouteCoordinator(
      ProfilePage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService);
}
