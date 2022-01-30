import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/shared/input_text.dart';
import 'package:flutter_plogging/src/ui/components/shared/upload_image.dart';

const int maxLengthName = 20;
const int maxLengthDescription = 100;

// ignore: must_be_immutable
class CreateRouteConfirmation extends StatefulWidget {
  final Function setName;
  final Function setDescription;
  final Function setImage;
  final Function uploadImage;
  String name = "";
  String description = "";

  CreateRouteConfirmation(
      {required this.setName,
      required this.setDescription,
      required this.setImage,
      required this.uploadImage,
      Key? key})
      : super(key: key);

  @override
  _CreateRouteConfirmation createState() => _CreateRouteConfirmation();
}

class _CreateRouteConfirmation extends State<CreateRouteConfirmation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 300, child: _getForm());
  }

  Widget _getForm() {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          InputText(
              textController: TextEditingController(text: widget.name),
              label: "Name",
              hint: "Route name",
              icon: const Icon(Icons.near_me),
              maxLength: 20,
              onChange: widget.setName),
          const SizedBox(height: 15),
          InputText(
              textController: TextEditingController(text: widget.description),
              label: "Description",
              hint: "Route description",
              icon: const Icon(Icons.my_library_books_outlined),
              maxLength: 150,
              inputType: TextInputType.multiline,
              onChange: widget.setDescription,
              isPasswordField: false,
              maxLines: 7),
          const SizedBox(height: 15),
          UploadImage(
            uploadImage: widget.uploadImage,
            isListView: false,
          ),
        ]);
  }
}
