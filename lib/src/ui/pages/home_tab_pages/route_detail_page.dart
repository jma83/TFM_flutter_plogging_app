import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button_like.dart';
import 'package:flutter_plogging/src/ui/components/widget_route_author.dart';
import 'package:flutter_plogging/src/ui/notifiers/route_detail_notifier.dart';
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
        onModelReady: (viewModel) {
          viewModel.addListener(() {}, [RouteDetailNotifier.updatePage]);
        },
        builder: (context, RouteDetailPageViewModel viewModel, child) {
          return Scaffold(
            floatingActionButton: InputButtonLike(
                liked: viewModel.route.isLiked,
                likeCallback: viewModel.manageLikeRoute),
            appBar: AppBar(title: const Text("Route Detail")),
            body: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1)),
                      child: InkWell(
                        child: ListView(
                          children: [
                            getHeaderDetailInfo(context),
                            const SizedBox(
                              height: 30,
                            ),
                            geDistanceAndDurationInfo(),
                            const SizedBox(
                              height: 16,
                            ),
                            getMap(context),
                            const SizedBox(
                              height: 22,
                            ),
                            getDescription(),
                            const SizedBox(
                              height: 20,
                            ),
                            getImageTitle(),
                            const SizedBox(
                              height: 20,
                            ),
                            getImage(context)
                          ],
                        ),
                      ),
                    ))),
          );
        });
  }

  Widget getMap(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 1.6,
        child: GoogleMap(
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
        ));
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

  getTitle(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 1, color: Colors.black54, style: BorderStyle.solid)),
        child: Text(
          viewModel.route.name!,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
        ));
  }

  getAuthorWidget() {
    return WidgetRouteAuthor(
        name: viewModel.author.username,
        level: viewModel.author.level,
        image: viewModel.author.image,
        date: viewModel.getRouteDateWithFormat());
  }

  getHeaderDetailInfo(BuildContext context) {
    return Container(
        color: Colors.grey[300],
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getTitle(context),
              const SizedBox(
                height: 5,
              ),
              getAuthorWidget()
            ]));
  }

  geDistanceAndDurationInfo() {
    return Row(
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
    );
  }

  getDescription() {
    return viewModel.route.description!.isNotEmpty
        ? Text(
            "Description: ${viewModel.route.description}",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          )
        : const Text(
            "No description found",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          );
  }

  getImageTitle() {
    return viewModel.route.image != null && viewModel.route.image != ""
        ? const Text(
            "Image:",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          )
        : const Text(
            "No image found",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          );
  }

  getImage(BuildContext context) {
    return SizedBox(
      child: viewModel.route.image != null && viewModel.route.image != ""
          ? getImageFromNetwork()
          : Container(),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
    );
  }
}
