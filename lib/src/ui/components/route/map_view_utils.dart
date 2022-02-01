import 'package:flutter/material.dart';

enum MapButtonType { zoomIn, zoomOut, myLocation }

class MapViewUtils extends StatelessWidget {
  final Widget mapWidget;
  final Widget? extraWidget;
  final Function zoomInCallback;
  final Function zoomOutCallback;
  final Function myLocationCallback;
  final bool isGeolocationActive;
  final bool hasStartedRoute;
  final double offsetTopZoom;
  final double offsetTopMyLocation;

  const MapViewUtils(
      {required this.mapWidget,
      required this.myLocationCallback,
      required this.zoomInCallback,
      required this.zoomOutCallback,
      this.extraWidget,
      this.isGeolocationActive = false,
      this.hasStartedRoute = false,
      this.offsetTopZoom = 0,
      this.offsetTopMyLocation = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      mapWidget,
      getZoomButtons(),
      getMyLocationButton(),
      extraWidget ?? Container()
    ]);
  }

  Widget getZoomButtons() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: offsetTopZoom),
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
            padding: EdgeInsets.only(
                right: 10.0, bottom: 10.0, top: offsetTopMyLocation),
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
        color: Colors.black54,
        child: InkWell(
          splashColor: Colors.blue,
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
    Function callback = zoomInCallback;
    IconData iconData = Icons.add;

    if (buttonType == MapButtonType.zoomOut) {
      callback = zoomOutCallback;
      iconData = Icons.remove;
    }

    if (buttonType == MapButtonType.myLocation) {
      callback = myLocationCallback;
      iconData = Icons.my_location;
    }

    return [callback, iconData];
  }
}
