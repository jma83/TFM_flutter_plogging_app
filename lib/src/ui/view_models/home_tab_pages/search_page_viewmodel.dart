import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPageViewModel extends HomeTabsChangeNotifier {
  String _searchValue = "";
  bool _isLoading = false;
  List<UserData> _users = [];
  UserStoreService userStoreService;
  SearchPageViewModel(authenticationService, this.userStoreService)
      : super(authenticationService);

  setSearchValue(String value) {
    _searchValue = value;
  }

  Future<void> submitSearch(String value) async {
    toggleLoading();
    _users = await userStoreService.queryElementLikeByCriteria(
        UserFieldData.username, value);
    toggleLoading();
    print("usersss! $_users");
    notifyListeners("update_search_page");
  }

  toggleLoading() {
    _isLoading ? EasyLoading.dismiss() : EasyLoading.show(status: 'loading...');
    _isLoading = !_isLoading;
  }

  get searchValue {
    return _searchValue;
  }

  List<UserData> get users {
    return _users;
  }
}
