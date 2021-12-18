import 'package:flutter/material.dart';

class WidgetRouteAuthor extends StatefulWidget {
  final String name;
  final int level;
  final String date;
  final String? image;
  const WidgetRouteAuthor(
      {required this.name,
      required this.level,
      required this.date,
      this.image,
      Key? key})
      : super(key: key);

  @override
  _WidgetRouteAuthorState createState() => _WidgetRouteAuthorState();
}

class _WidgetRouteAuthorState extends State<WidgetRouteAuthor> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          margin: const EdgeInsets.only(top: 12),
          child: SizedBox(
              width: 50,
              height: 50,
              child: widget.image == null || widget.image == ""
                  ? getImageFromAsset()
                  : getImageFromNetwork())),
      title: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Level: ${widget.level}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      trailing: Text(
        "Date: ${widget.date}",
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.end,
      ),
    );
  }

  getImageFromNetwork() {
    const String image = "assets/logo.png";

    return FadeInImage.assetNetwork(
      image: widget.image!,
      placeholder: image,
      fadeInDuration: const Duration(milliseconds: 200),
      fit: BoxFit.contain,
    );
  }

  getImageFromAsset() {
    const String image = "assets/logo.png";
    return const FadeInImage(
        image: AssetImage(image),
        placeholder: AssetImage(image),
        fadeInDuration: Duration(milliseconds: 200),
        fit: BoxFit.contain);
  }
}
