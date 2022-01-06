import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/alert.dart';
import 'package:flutter_plogging/src/ui/components/create_route_confirmation.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/start_plogging_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/start_plogging_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MapButtonType { zoomIn, zoomOut, myLocation }

@injectable
class StartPloggingPage extends StatelessWidget {
  final StartPloggingPageViewModel viewModel;
  const StartPloggingPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartPloggingPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.loadPage();
          viewModel
              .addListener(() {}, [StartPloggingNotifiers.updatePloggingPage]);
          viewModel.confirmRouteCallback =
              () => showRouteConfirmationAlert(context);
          viewModel.addListener(viewModel.confirmRouteCallback!,
              [StartPloggingNotifiers.confirmRoutePlogging]);
        },
        onDispose: (viewModel) {
          viewModel.removeListener(
              () {}, [StartPloggingNotifiers.updatePloggingPage]);
          viewModel.removeListener(viewModel.confirmRouteCallback!,
              [StartPloggingNotifiers.confirmRoutePlogging]);
        },
        builder: (context, StartPloggingPageViewModel viewModel, child) {
          return Scaffold(
              appBar: AppBar(title: const Text("Plogging")),
              body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(children: <Widget>[
                    getMap(),
                    getZoomButtons(),
                    getMyLocationButton(),
                    getRouteButton()
                  ])));
        });
  }

  Widget getMap() {
    return GoogleMap(
      polylines: Set<Polyline>.of(viewModel.polylines.values),
      initialCameraPosition: CameraPosition(
          target: LatLng(viewModel.currentPosition.latitude,
              viewModel.currentPosition.longitude),
          zoom: viewModel.currentZoom),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      zoomGesturesEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        viewModel.setMapController(controller);
        viewModel.setCameraToCurrentLocation(first: true);
      },
    );
  }

  Widget getZoomButtons() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getMapButtonByType(MapButtonType.zoomIn),
            const SizedBox(height: 20),
            getMapButtonByType(MapButtonType.zoomOut)
          ],
        ),
      ),
    );
  }

  Widget getMyLocationButton() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
            child: getMapButtonByType(MapButtonType.myLocation)),
      ),
    );
  }

  Widget getMapButtonByType(MapButtonType buttonType) {
    dynamic buttonTypeData = getDataByButtonType(buttonType);
    Function callback = buttonTypeData[0];
    IconData iconData = buttonTypeData[1];
    return ClipOval(
      child: Material(
        color: Colors.black54, // button color
        child: InkWell(
          splashColor: Colors.blue, // inkwell color
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          onTap: () {
            callback();
          },
        ),
      ),
    );
  }

  dynamic getDataByButtonType(MapButtonType buttonType) {
    //  MapButtonType.zoomIn
    Function callback = viewModel.zoomIn;
    IconData iconData = Icons.add;

    if (buttonType == MapButtonType.zoomOut) {
      callback = viewModel.zoomOut;
      iconData = Icons.remove;
    }

    if (buttonType == MapButtonType.myLocation) {
      callback = viewModel.setCameraToCurrentLocation;
      iconData = Icons.my_location;
    }

    return [callback, iconData];
  }

  Widget getRouteButton() {
    return SafeArea(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: getRouteButtonByType())));
  }

  Widget getRouteButtonByType() {
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

  showRouteConfirmationAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Alert.createCustomOptionsAlert(
            "Create route confirmation",
            CreateRouteConfirmation(
              setName: viewModel.setRouteName,
              setDescription: viewModel.setRouteDescription,
              setImage: viewModel.setRouteImage,
              uploadImage: viewModel.uploadRouteImage,
            ),
            viewModel.confirmRoute,
            viewModel.dismissAlert));
  }
}
