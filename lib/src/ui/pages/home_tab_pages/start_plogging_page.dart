import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/start_plogging_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class StartPloggingPage extends StatelessWidget {
  final StartPloggingPageViewModel viewModel;
  const StartPloggingPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartPloggingPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(() {}, ["update_start_plogging_page"]);
        },
        builder: (context, StartPloggingPageViewModel viewModel, child) {
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [getButton()],
          ));
        });
  }

  Widget getButton() {
    return !viewModel.hasStartedRoute
        ? InputButton(
            label: const Text("Start"),
            onPress: () => viewModel.beginRoute(),
            buttonType: InputButtonType.elevated,
          )
        : InputButton(
            label: const Text("End"),
            onPress: () => viewModel.endRoute(),
            buttonType: InputButtonType.outlined);
  }
}
