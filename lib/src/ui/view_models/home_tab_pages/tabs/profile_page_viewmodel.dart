import 'package:flutter_plogging/src/core/application/route/get_today_user_distance.dart';
import 'package:flutter_plogging/src/core/application/user/update_user_image.dart';
import 'package:flutter_plogging/src/core/domain/gender/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/image_picker_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/profile_notifiers.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/app_constants.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePageViewModel extends HomeTabsChangeNotifier {
  final LoadingService _loadingService;
  final GetTodayUserDistance _getTodayUserDistance;
  final UpdateUserImage _updateUserImage;
  final ImagePickerService _imagePickerService;
  int _objectiveProgress = 0;
  XFile? tmpImage;
  ProfilePageViewModel(
      authenticationService,
      this._loadingService,
      this._getTodayUserDistance,
      this._updateUserImage,
      this._imagePickerService)
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

  onClickImage() {
    notifyListeners(ProfileNotifiers.showUploadImage);
  }

  Future<void> updateUserImage() async {
    if (tmpImage == null) return;
    _loadingService.setLoading(true);
    await _updateUserImage.execute(tmpImage!.path);
    tmpImage = null;
    updatePage();
    dismissAlert();

    _loadingService.setLoading(false);
  }

  Future<XFile?> uploadImage(ImageSource? imageSource) async {
    if (imageSource == null) {
      tmpImage = null;
      return null;
    }
    final XFile? image = await _imagePickerService.pickImage(imageSource);
    tmpImage = image;
    return image;
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

  int get maxXp {
    return currentUser.level * AppConstants.incrementXP + AppConstants.baseXP;
  }
}
