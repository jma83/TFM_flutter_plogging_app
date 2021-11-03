import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchRouteCoordinator extends ParentRouteCoordinator {
  SearchRouteCoordinator(
      SearchPage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService);
}
