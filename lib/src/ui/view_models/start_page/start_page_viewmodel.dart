import 'package:flutter_plogging/src/ui/route_coordinators/start_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@injectable
class StartPageViewModel extends PropertyChangeNotifier<String> {
  final StartPageRouteCoordinator routeCoordinator;
  StartPageViewModel(this.routeCoordinator);

  void getFutureTimeout() {
    Future.delayed(
        const Duration(seconds: 2), () => routeCoordinator.navigateToLogin());
  }
}
