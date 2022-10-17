import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../exports/resources.dart';
import '../../exports/widgets.dart';
import 'custom_dialog.dart';

class SelectAlbumWidget extends StatefulWidget {
  SelectAlbumWidget(
      {required this.numberOfFile, required this.imagePath, Key? key})
      : super(key: key);

  ValueSetter<File> imagePath;
  int numberOfFile;

  @override
  State<SelectAlbumWidget> createState() => _SelectAlbumWidgetState();
}

class _SelectAlbumWidgetState extends State<SelectAlbumWidget> {
  late File cameraFile;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Expanded(
            child: Visibility(
              visible: false,
              child: CustomTextInputField(
                  labelText: "Photo Detail", hintText: 'Outside'),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: openCamera,
              child: const SvgImageView(
                path: AppAssets.icCamera,
                height: 40,
              )),
        ],
      );

  openCamera() async {
    if (widget.numberOfFile < 3) {
      var pickFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      cameraFile = File(pickFile!.path);
      print('File : $cameraFile');
      widget.imagePath(cameraFile);
      setState(() {});
    } else {
      await showDialog(
          context: context,
          builder: (context) => CustomDialog(
                content: 'Image upload limit is 3 for each folder',
                title: AppStrings.lblAddMore,
                yes: AppStrings.ok,
                yesOnPressed: () {
                },
              ));
    }
  }
}
