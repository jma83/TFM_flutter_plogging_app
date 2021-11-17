import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPloggingPageViewModel extends HomeTabsChangeNotifier {
  RouteStoreService _routeStoreService;
  StartPloggingPageViewModel(
      AuthenticationService authenticationService, this._routeStoreService)
      : super(authenticationService);

  bool _startedRoute = false;

  beginRoute() {
    _startedRoute = true;
  }

  endRoute() {
    _startedRoute = false;
  }
}
