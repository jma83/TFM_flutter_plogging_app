import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';

class ProfilePageViewModel extends HomeTabsChangeNotifier {
  final LoadingService _loadingService;
  ProfilePageViewModel(authenticationService, this._loadingService)
      : super(authenticationService);

  confirmLogoutProfile() {
    _loadingService.setLoading(true);
    authenticationService.signOut();
    dismissAlert();
  }

  @override
  loadPage() {
    updatePage();
  }

  @override
  updatePage() {
    notifyListeners(ProfileNotifiers.updateProfilePage);
  }

  logout() {
    notifyListeners(ProfileNotifiers.showLogoutConfirmation);
  }

  dismissAlert() {
    notifyListeners(ProfileNotifiers.goBackDismiss);
  }

  navigateToEdit() {
    notifyListeners(ProfileNotifiers.navigateToEditProfile);
  }

  navigateToLikedRoutes() {
    notifyListeners(ProfileNotifiers.navigateToLikedRoutes);
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
