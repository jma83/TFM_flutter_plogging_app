// ignore_for_file: constant_identifier_names
import 'package:flutter_plogging/src/core/application/update_user.dart';
import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/edit_profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfilePageViewModel extends HomeTabsChangeNotifier {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  String _age = "";
  String _gender = "";
  String _errorMessage = "";

  final LoadingService _loadingService;
  final UserViewModel _userViewModel;
  final UpdateUser _updateUser;

  EditProfilePageViewModel(AuthenticationService authenticationService,
      this._userViewModel, this._loadingService, this._updateUser)
      : super(authenticationService);

  @override
  loadPage() {
    _username = authenticationService.currentUserData!.username;
    _age = authenticationService.currentUserData!.age.toString();
    _gender = Gender.getGenderFromIndex(
        authenticationService.currentUserData!.gender);
    notifyListeners(EditProfileNotifiers.updateEditProfilePage);
  }

  void validateForm() {
    toggleLoading();
    if (!_userViewModel.validateRegister(_email, _username, _password,
        _confirmPassword, _age, Gender.getGenderIndex(_gender).toString())) {
      setError(_userViewModel.errorMessage);
      return;
    }
    validationOkResponse();
  }

  void validationOkResponse() async {
    await _updateUser.execute(
        authenticationService.currentUser!.uid,
        UserData(
            id: authenticationService.currentUser!.uid,
            username: _username,
            age: int.parse(_age),
            gender: Gender.getGenderIndex(_gender)));
    toggleLoading();
  }

  toggleLoading() {
    _loadingService.toggleLoading();
  }

  setError(String errorValue) {
    _errorMessage = errorValue;
    toggleLoading();
    notifyListeners(EditProfileNotifiers.editProfileProcessError);
  }

  void dismissAlert() {
    notifyListeners(EditProfileNotifiers.navigateToPrevious);
  }

  void setEmail(String email) {
    _email = email;
  }

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  void setAge(String age) {
    _age = age;
  }

  void setGender(String gender) {
    _gender = gender;
  }

  String get gender {
    return _gender;
  }

  String get age {
    return _age;
  }

  String get username {
    return _username;
  }

  String get email {
    return authenticationService.currentUser!.email!;
  }

  get errorMessage {
    return _errorMessage;
  }
}
