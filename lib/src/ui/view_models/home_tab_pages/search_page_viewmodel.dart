import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPageViewModel extends HomeTabsChangeNotifier {
  String _searchValue = "";
  List<UserData> _users = [];
  UserStoreService userStoreService;
  SearchPageViewModel(authenticationService, this.userStoreService)
      : super(authenticationService);

  setSearchValue(String value) {
    _searchValue = value;
  }

  Future<void> submitSearch(String value) async {
    // TODO search
    _users = await userStoreService.queryElementLikeByCriteria(
        UserFieldData.username, value);
    print("usersss! ${_users[0].age}");
    notifyListeners("update_search_page");
  }

  get searchValue {
    return _searchValue;
  }

  List<UserData> get users {
    return _users;
  }
}
