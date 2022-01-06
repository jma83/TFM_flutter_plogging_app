// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';

class RouteListAuthorData {
  RouteListData routeListData;
  UserSearchData userData;
  RouteListAuthorData(this.routeListData, this.userData);

  static List<RouteListAuthorData> convertRoutes(
      List<RouteListData> routes, List<UserData> users) {
    List<RouteListAuthorData> _routesWithAuthor = [];
    for (int i = 0; i < routes.length; i++) {
      UserData? userData =
          users.firstWhereOrNull((element) => element.id == routes[i].userId);
      if (userData == null) continue;
      _routesWithAuthor = [
        ..._routesWithAuthor,
        RouteListAuthorData(routes[i], UserSearchData(user: userData))
      ];
    }
    return _routesWithAuthor;
  }

  static List<RouteListAuthorData> convertRoutesUniqueUser(
      List<RouteListData> routes, UserData user) {
    List<RouteListAuthorData> _routesWithAuthor = [];
    for (int i = 0; i < routes.length; i++) {
      _routesWithAuthor = [
        ..._routesWithAuthor,
        RouteListAuthorData(routes[i], UserSearchData(user: user))
      ];
    }
    return _routesWithAuthor;
  }
}
