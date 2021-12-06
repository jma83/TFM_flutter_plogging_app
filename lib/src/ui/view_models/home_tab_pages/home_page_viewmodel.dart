import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageViewModel extends HomeTabsChangeNotifier {
  String _username = "";
  int _age = 0;
  int _gender = 0;
  HomePageViewModel(authenticationService, userStoreService)
      : super(authenticationService, userStoreService) {
    findUserData();
  }

  void findUserData() async {
    UserData? user = await userStoreService.queryElementById(currentUser.id);
    print("user!! $user");
    if (user == null) {
      return;
    }
    _username = user.username;
    _age = user.age;
    _gender = user.gender;
    notifyListeners("update_home_page");
  }

  String get username {
    return _username;
  }

  int get age {
    return _age;
  }

  int get gender {
    return _gender;
  }
}
