// ignore_for_file: must_call_super

import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class HomeTabsChangeNotifier extends PropertyChangeNotifier<String> {
  AuthenticationService authenticationService;

  HomeTabsChangeNotifier(this.authenticationService);

  UserData get currentUser {
    final user = authenticationService.currentUserData;
    if (user == null) {
      return UserData(username: "", age: 0, gender: 0);
    }

    return authenticationService.currentUserData!;
  }

  String get currentUserId {
    if (currentUser.username.isEmpty) return "";
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
  dispose() {}
}
