import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class HomeTabsChangeNotifier extends PropertyChangeNotifier<String> {
  AuthenticationService authenticationService;
  UserStoreService userStoreService;

  HomeTabsChangeNotifier(this.authenticationService, this.userStoreService) {
    loadCurrentUserData();
  }
  late UserData currentUser;

  String get currenUserId {
    return currentUser.id;
  }

  loadCurrentUserData() async {
    currentUser = (await userStoreService
        .queryElementById(authenticationService.currentUser!.uid))!;
  }

  @override
  dispose() {
    if (authenticationService.currentUser == null) {
      super.dispose();
    }
  }
}
