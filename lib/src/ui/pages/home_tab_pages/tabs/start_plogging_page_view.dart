import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/utils/alert_utils.dart';
import 'package:flutter_plogging/src/ui/components/create_route_confirmation.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/map_view_utils.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/start_plogging_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/start_plogging_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@injectable
class StartPloggingPageView extends HomePageWidget {
  const StartPloggingPageView(StartPloggingPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartPloggingPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as StartPloggingPageViewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel
              .addListener(() {}, [StartPloggingNotifiers.updatePloggingPage]);
          viewModel.addListener(() => showRouteConfirmationAlert(context),
              [StartPloggingNotifiers.confirmRoutePlogging]);
          viewModel.addListener(() => showErrorAlert(context),
              [StartPloggingNotifiers.errorRoutePlogging]);
          viewModel.addListener(() => showLevelAlert(context),
              [StartPloggingNotifiers.userLevelUp]);
        },
        builder: (context, StartPloggingPageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("Plogging")),
              body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: MapViewUtils(
                    mapWidget: getMap(),
                    extraWidget: getRouteButton(),
                    myLocationCallback:
                        currentViewModel.setCameraToCurrentLocation,
                    zoomInCallback: currentViewModel.zoomIn,
                    zoomOutCallback: currentViewModel.zoomOut,
                  )));
        });
  }

  Widget getMap() {
    return GoogleMap(
        polylines: Set<Polyline>.of(currentViewModel.polylines),
        initialCameraPosition: CameraPosition(
            target: LatLng(currentViewModel.currentPosition.latitude,
                currentViewModel.currentPosition.longitude),
            zoom: currentViewModel.currentZoom,
            bearing: currentViewModel.currentPosition.heading),
        myLocationEnabled: currentViewModel.isServiceEnabled,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        scrollGesturesEnabled: !currentViewModel.hasStartedRoute,
        zoomGesturesEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: !currentViewModel.hasStartedRoute,
        onMapCreated: (GoogleMapController controller) {
          currentViewModel.setMapController(controller);
          currentViewModel.setCameraToCurrentLocation(first: true);
        });
  }

  Widget getRouteButton() {
    return SafeArea(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: getRouteButtonsByType())));
  }

  Widget getRouteButtonsByType() {
    return !currentViewModel.hasStartedRoute
        ? InputButton(
            label: const Text("Start"),
            onPress: () => currentViewModel.beginRoute(),
            buttonType: InputButtonType.elevated,
          )
        : InputButton(
            label: const Text("End"),
            onPress: () => currentViewModel.endRoute(),
            buttonType: InputButtonType.outlined);
  }

  showErrorAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertUtils.createInfoAlert("Error",
            currentViewModel.errorMessage, currentViewModel.dismissAlert));
  }

  showLevelAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertUtils.createInfoAlert(
            "Congratulations!",
            "You have reached level ${currentViewModel.currentUser.level}!",
            currentViewModel.dismissAlert));
  }

  showRouteConfirmationAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertUtils.createCustomOptionsAlert(
            "Create route confirmation",
            CreateRouteConfirmation(
              setName: currentViewModel.setRouteName,
              setDescription: currentViewModel.setRouteDescription,
              setImage: currentViewModel.setRouteImage,
              uploadImage: currentViewModel.uploadRouteImage,
            ),
            currentViewModel.confirmRoute,
            currentViewModel.dismissAlert));
  }

  StartPloggingPageViewModel get currentViewModel {
    return viewModel as StartPloggingPageViewModel;
  }
}
