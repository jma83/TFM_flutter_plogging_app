import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/pages/page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';

abstract class HomePageWidget extends PageWidget {
  const HomePageWidget(HomeTabsChangeNotifier viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context);
}
