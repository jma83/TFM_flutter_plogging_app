import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class HomePageViewModel extends PropertyChangeNotifier<String> {
  AuthenticationService authenticationService;
  UserStoreService userStoreService;
  String _username = "";
  int _age = 0;
  int _gender = 0;
  HomePageViewModel(this.authenticationService, this.userStoreService);

  User get currentUser {
    return authenticationService.currentUser!;
  }

  void findUserData() async {
    final user = await userStoreService.queryElementById(currentUser.uid);

    _username = user!.username;
    _age = user.age;
    _gender = user.gender;
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
