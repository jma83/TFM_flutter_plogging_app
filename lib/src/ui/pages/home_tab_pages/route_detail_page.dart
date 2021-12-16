import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/route_detail_page_viewmodel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class RouteDetailPage extends StatelessWidget {
  RouteDetailPageViewModel viewModel;
  RouteDetailPage(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteDetailPageViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) => {},
        builder: (context, RouteDetailPageViewModel viewModel, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.thumb_up),
            ),
            appBar: AppBar(title: const Text("Route Detail")),
            body: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.green,
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      child: InkWell(
                        child: ListView(
                          children: [
                            Container(
                                color: Colors.grey[300],
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black54,
                                                  style: BorderStyle.solid)),
                                          child: Text(
                                            viewModel.route.name!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ListTile(
                                        leading: Container(
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          child: const SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/logo.png"),
                                              )),
                                        ),
                                        title: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 5),
                                                const Text(
                                                  "epepe",
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      "Level:",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: Text(
                                          "Date: 10-09-2000",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      )
                                    ])),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Distance: ${viewModel.route.distance}m",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Duration: ${viewModel.route.duration}s",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width / 1.6,
                                child: getMap()),
                            SizedBox(
                              height: 22,
                            ),
                            viewModel.route.description!.isNotEmpty
                                ? Text(
                                    "Description: ${viewModel.route.description}",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    "No description found",
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            viewModel.route.image != null &&
                                    viewModel.route.image != ""
                                ? Text(
                                    "Image:",
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    "No image found",
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              child: viewModel.route.image != null &&
                                      viewModel.route.image != ""
                                  ? getImageFromNetwork()
                                  : Container(),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 2,
                            ),
                          ],
                        ),
                      ),
                    ))),
          );
        });
  }

  Widget getMap() {
    return GoogleMap(
      //polylines: Set<Polyline>.of(viewModel.polylines.values),
      initialCameraPosition: CameraPosition(target: LatLng(38, 8), zoom: 8),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      scrollGesturesEnabled: false,
      mapType: MapType.normal,
      zoomGesturesEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        viewModel.setMapController(controller);
        // viewModel.setCameraToCurrentLocation(first: true);
      },
    );
  }

  getImageFromNetwork() {
    const String image = "assets/img1.jpg";

    return FadeInImage.assetNetwork(
      image: viewModel.route.image!,
      placeholder: image,
      height: 100,
      fadeInDuration: const Duration(milliseconds: 200),
      fit: BoxFit.cover,
    );
  }
}
