import 'package:flutter/foundation.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageViewModel extends ChangeNotifier {
  final StartPageRouteCoordinator routeCoordinator;
  StartPageViewModel(this.routeCoordinator);

  void getFutureTimeout() {
    Future.delayed(
        const Duration(seconds: 2), () => routeCoordinator.navigateToLogin());
  }
}
