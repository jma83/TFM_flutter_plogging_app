import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/ui/notifiers/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';

class ProfilePageViewModel extends HomeTabsChangeNotifier {
  ProfilePageViewModel(authenticationService) : super(authenticationService);

  confirmLogoutProfile() {
    authenticationService.signOut();
    dismissAlert();
  }

  logout() {
    notifyListeners(ProfileNotifiers.showLogoutConfirmation);
  }

  dismissAlert() {
    notifyListeners(ProfileNotifiers.goBackDismiss);
  }

  String get formattedCreationDate {
    if (user == null) return "";

    return DateCustomUtils.dateTimeToStringFormat(user!.creationDate.toDate(),
        onlyDate: true);
  }

  String get formattedGender {
    if (user == null) return "";
    return Gender.getGenderFromIndex(user!.gender);
  }

  UserSearchData? get user {
    if (authenticationService.currentUserData == null) return null;
    return UserSearchData(user: authenticationService.currentUserData!);
  }
}
