import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/start_plogging_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(children: <Widget>[
                GoogleMap(
                  initialCameraPosition:
                      const CameraPosition(target: LatLng(0.0, 0.0)),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    viewModel.setMapController(controller);
                  },
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.blue.shade100, // button color
                            child: InkWell(
                              splashColor: Colors.blue, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.add),
                              ),
                              onTap: () {
                                viewModel.mapController.animateCamera(
                                  CameraUpdate.zoomIn(),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ClipOval(
                          child: Material(
                            color: Colors.blue.shade100, // button color
                            child: InkWell(
                              splashColor: Colors.blue, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.remove),
                              ),
                              onTap: () {
                                viewModel.mapController.animateCamera(
                                  CameraUpdate.zoomOut(),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange.shade100, // button color
                          child: InkWell(
                            splashColor: Colors.orange, // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(Icons.my_location),
                            ),
                            onTap: () {
                              viewModel.mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      viewModel.currentPosition.latitude,
                                      viewModel.currentPosition.longitude,
                                    ),
                                    zoom: 18.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]));
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
