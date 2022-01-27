// ignore_for_file: must_call_super

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class HomeTabsChangeNotifier extends PropertyChangeNotifier<String> {
  final AuthenticationService authenticationService;
  TabItem? nextTabItem;

  HomeTabsChangeNotifier(this.authenticationService);

  UserData get currentUser {
    final user = authenticationService.currentUserData;
    if (user == null) {
      return UserData(
          id: "",
          username: "",
          age: 0,
          gender: 0,
          creationDate: Timestamp.now());
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
