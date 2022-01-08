import 'package:flutter_plogging/src/core/application/get_today_user_distance.dart';
import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/app_constants.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';

class ProfilePageViewModel extends HomeTabsChangeNotifier {
  final LoadingService _loadingService;
  final GetTodayUserDistance _getTodayUserDistance;
  int _objectiveProgress = 0;
  ProfilePageViewModel(
      authenticationService, this._loadingService, this._getTodayUserDistance)
      : super(authenticationService);

  confirmLogoutProfile() {
    _loadingService.setLoading(true);
    authenticationService.signOut();
    dismissAlert();
  }

  @override
  loadPage() async {
    _loadingService.setLoading(true);
    await calcTodaysObjectiveProgress();
    updatePage();
    _loadingService.setLoading(false);
  }

  @override
  updatePage() {
    notifyListeners(ProfileNotifiers.updateProfilePage);
  }

  Future<void> calcTodaysObjectiveProgress() async {
    final distance = await _getTodayUserDistance.execute();
    _objectiveProgress =
        (100 * distance / AppConstants.objectiveDistance).round();
  }

  redirectToPlogging() {
    nextTabItem = TabItem.plogging;
    notifyListeners(HomeTabsNotifiers.redirectHomeTabNavigation);
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

  int get objectiveProgress {
    return _objectiveProgress;
  }
}
