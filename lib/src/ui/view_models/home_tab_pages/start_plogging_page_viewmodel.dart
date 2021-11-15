import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPloggingPageViewModel extends HomeTabsChangeNotifier {
  StartPloggingPageViewModel(AuthenticationService authenticationService)
      : super(authenticationService);
}
