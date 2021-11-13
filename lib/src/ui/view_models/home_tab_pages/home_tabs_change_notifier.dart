import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class HomeTabsChangeNotifier extends PropertyChangeNotifier<String> {
  AuthenticationService authenticationService;
  HomeTabsChangeNotifier(this.authenticationService);
  @override
  dispose() {
    if (authenticationService.currentUser == null) {
      super.dispose();
    }
  }
}
