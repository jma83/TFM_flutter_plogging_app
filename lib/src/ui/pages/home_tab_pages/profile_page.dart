import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/profile_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  final ProfilePageViewModel viewModel;
  const ProfilePage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) =>
            print("JOSUE! ${context.findRenderObject()}"),
        builder: (context, ProfilePageViewModel viewModel, child) => Scaffold(
            appBar: AppBar(title: const Text("Profile")), body: Container()));
  }
}
