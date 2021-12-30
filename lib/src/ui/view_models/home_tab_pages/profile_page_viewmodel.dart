import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/ui/notifiers/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
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

  get formattedCreationDate {
    return DateCustomUtils.dateTimeToStringFormat(user.creationDate.toDate(),
        onlyDate: true);
  }

  get formattedGender {
    return Gender.getGenderFromIndex(user.gender);
  }

  UserSearchData get user {
    return UserSearchData(user: authenticationService.currentUserData!);
  }
}
