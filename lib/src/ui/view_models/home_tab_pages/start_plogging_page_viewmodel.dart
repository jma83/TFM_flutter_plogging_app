import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPloggingPageViewModel extends HomeTabsChangeNotifier {
  RouteStoreService _routeStoreService;
  UiidGeneratorService _uiidGeneratorService;
  StartPloggingPageViewModel(AuthenticationService authenticationService,
      this._routeStoreService, this._uiidGeneratorService)
      : super(authenticationService);

  bool _hasStartedRoute = false;

  beginRoute() {
    _hasStartedRoute = true;
    notifyListeners("update_start_plogging_page");
  }

  endRoute() {
    if (!_hasStartedRoute) {
      return;
    }
    _hasStartedRoute = false;
    _routeStoreService.addElement(
        RouteData(
            name: "Example",
            description: "Description example",
            userId: authenticationService.currentUser!.uid),
        _uiidGeneratorService.generate());
    notifyListeners("update_start_plogging_page");
  }

  get hasStartedRoute {
    return _hasStartedRoute;
  }
}
