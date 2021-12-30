import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class HomeTabsChangeNotifier extends PropertyChangeNotifier<String> {
  AuthenticationService authenticationService;

  HomeTabsChangeNotifier(this.authenticationService);

  UserData get currentUser {
    return authenticationService.currentUserData!;
  }

  String get currentUserId {
    return currentUser.id;
  }

  loadPage() {
    // implements on child
  }

  updatePage() {
    // implements on child
  }

  updateData(RouteListAuthorSearchData data) {
    // implements on child
  }

  @override
  dispose() {
    if (authenticationService.currentUser == null) {
      super.dispose();
    }
  }
}
