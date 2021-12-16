import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class RouteDetailPageViewModel extends HomeTabsChangeNotifier {
  late RouteListData _routeListData;
  late GoogleMapController mapController;

  RouteDetailPageViewModel(AuthenticationService authenticationService)
      : super(authenticationService);

  setRoute(RouteListData route) {
    _routeListData = route;
  }

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
  }

  RouteListData get route {
    return _routeListData;
  }
}
