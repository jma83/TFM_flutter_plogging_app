import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/how_it_works_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class HowItWorksPageViewModel extends HomeTabsChangeNotifier {
  HowItWorksPageViewModel(AuthenticationService authService)
      : super(authService);

  navigateToPrevious() {
    notifyListeners(HowItWorksNotifiers.navigateToPrevious);
  }
}
