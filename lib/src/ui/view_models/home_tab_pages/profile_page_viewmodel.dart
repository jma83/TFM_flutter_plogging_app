import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';

class ProfilePageViewModel extends AuthPropertyChangeNotifier {
  ProfilePageViewModel(authenticationService, _userStoreService)
      : super(authenticationService, _userStoreService) {
    createAuthListener();
  }

  delayedLogoutProfile() {
    Future.delayed(const Duration(seconds: 1), () {
      authService.signOut();
    });
  }

  get formattedCreationDate {
    return DateCustomUtils.dateTimeToStringFormat(user.creationDate.toDate(),
        onlyDate: true);
  }

  get formattedGender {
    return Gender.getGenderFromIndex(user.gender);
  }

  @override
  void notifyNotLoggedIn() {
    notifyListeners("profileRouteCoordinator_navigateToLogin");
  }

  UserSearchData get user {
    return UserSearchData(user: authService.currentUserData!);
  }
}
