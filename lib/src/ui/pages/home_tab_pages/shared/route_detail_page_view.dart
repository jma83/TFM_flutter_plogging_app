import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/detail_content_container.dart';
import 'package:flutter_plogging/src/ui/components/input_button_like.dart';
import 'package:flutter_plogging/src/ui/components/map_view_utils.dart';
import 'package:flutter_plogging/src/ui/components/top_navigation_bar.dart';
import 'package:flutter_plogging/src/ui/components/badge_route_author.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page_widget.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/route_detail_page_viewmodel.dart';
import 'package:flutter_plogging/src/utils/image_widget_utils.dart';
import 'package:flutter_plogging/src/utils/text_widget_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class RouteDetailPageView extends HomePageWidget {
  const RouteDetailPageView(RouteDetailPageViewModel viewModel, {Key? key})
      : super(viewModel, key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteDetailPageViewModel>.reactive(
        viewModelBuilder: () => viewModel as RouteDetailPageViewModel,
        onModelReady: (viewModel) {
          viewModel.addListener(() {}, [RouteDetailNotifier.updatePage]);
        },
        builder: (context, RouteDetailPageViewModel viewModel, child) {
          return Scaffold(
              floatingActionButton: InputButtonLike(
                  id: viewModel.instanceId,
                  liked: viewModel.route.isLiked,
                  likeCallback: viewModel.manageLikeRoute),
              appBar: TopNavigationBar.getTopNavigationBar(
                  title: "Route detail",
                  isBackVisible: true,
                  goBackCallback: viewModel.navigateToPrevious),
              body: DetailContentContainer(getListViewRoute(context)));
        });
  }

  Widget getListViewRoute(BuildContext context) {
    return ListView(
      children: [
        getHeaderDetailInfo(context),
        const SizedBox(
          height: 30,
        ),
        geDistanceAndDurationInfo(),
        const SizedBox(
          height: 16,
        ),
        getMapWrapper(context),
        const SizedBox(
          height: 22,
        ),
        getDescription(),
        const SizedBox(
          height: 20,
        ),
        getImageTitle(),
        const SizedBox(
          height: 10,
        ),
        getImage(context),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget getMapWrapper(BuildContext context) {
    return MapViewUtils(
      mapWidget: getMap(context),
      myLocationCallback: currentViewModel.setCameraPosition,
      zoomInCallback: currentViewModel.zoomIn,
      zoomOutCallback: currentViewModel.zoomOut,
      offsetTopMyLocation: 240,
      offsetTopZoom: 80,
    );
  }

  Widget getMap(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 1.3,
        child: GoogleMap(
          polylines: Set<Polyline>.of(currentViewModel.polylines),
          initialCameraPosition:
              const CameraPosition(target: LatLng(0, 0), zoom: 8),
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          scrollGesturesEnabled: true,
          mapType: MapType.normal,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            currentViewModel.setMapController(controller);
            currentViewModel.setCameraPosition();
            currentViewModel.loadPolylines();
          },
        ));
  }

  getImageFromNetwork() {
    return ImageWidgetUtils.getImageFromNetwork(currentViewModel.route.image!,
        avatar: false, fit: BoxFit.cover, height: 100);
  }

  getTitle(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 1, color: Colors.black54, style: BorderStyle.solid)),
        child: Text(currentViewModel.route.name!,
            textAlign: TextAlign.center,
            style: TextWidgetUtils.getTitleStyleText(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Colors.black87)));
  }

  getAuthorWidget() {
    return BadgeRouteAuthor(
        name: currentViewModel.author.username,
        level: currentViewModel.author.level,
        image: currentViewModel.author.image,
        callbackAuthor: () => currentViewModel.navigateToAuthor(),
        date: currentViewModel.getRouteDateWithFormat());
  }

  getHeaderDetailInfo(BuildContext context) {
    return Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.symmetric(vertical: 16),
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
          "Distance: ${currentViewModel.truncateDistance()}m",
          style: TextWidgetUtils.getRegularStyleText(fontSize: 14),
        ),
        Text(
          "Duration: ${currentViewModel.route.duration}s",
          style: TextWidgetUtils.getRegularStyleText(fontSize: 14),
        ),
      ],
    );
  }

  getDescription() {
    return currentViewModel.route.description!.isNotEmpty
        ? Text(
            "Description: ${currentViewModel.route.description}",
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
    return currentViewModel.route.image != null &&
            currentViewModel.route.image != ""
        ? Text(
            "- Route Image -",
            style: TextWidgetUtils.getRegularStyleText(fontSize: 14),
            textAlign: TextAlign.center,
          )
        : Text(
            "This route has no image",
            style: TextWidgetUtils.getRegularStyleText(fontSize: 14),
            textAlign: TextAlign.center,
          );
  }

  getImage(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          child: currentViewModel.route.image != null &&
                  currentViewModel.route.image != ""
              ? getImageFromNetwork()
              : Container(),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2,
        ));
  }

  RouteDetailPageViewModel get currentViewModel {
    return viewModel as RouteDetailPageViewModel;
  }
}
