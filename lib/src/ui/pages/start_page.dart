import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page/start_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class StartPage extends StatelessWidget {
  final StartPageViewModel _viewModel;
  const StartPage(this._viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartPageViewModel>.reactive(
        viewModelBuilder: () => _viewModel,
        onModelReady: (viewModel) => viewModel.checkUserRedirection(),
        builder: (context, StartPageViewModel viewModel, child) =>
            getLoadingWidget());
  }

  Widget getLoadingWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: const [
              Image(
                image: AssetImage("assets/logo.png"),
                width: 220,
                height: 220,
              ),
              Text(
                "Plogging challenge",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.center,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ));
  }
}
