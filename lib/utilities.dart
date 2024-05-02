import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/view/widgets/customBottomSheet_imgPick.dart';

bool isArabic() => Intl.getCurrentLocale() == 'ar';

String displayLines(int i) {
  List<String> lines = [
    "١",
    "٢",
    "٣",
    "٤",
    "٥",
    "٦",
    "٧",
    "٨",
    "٩",
    "١٠",
    "١١",
    "١٢",
    "١٣",
    "١٤",
    "١٥",
    "١٦",
    "١٧"
  ];

  if (isArabic()) return lines[i - 1].toString();
  return i.toString();
}

final picker = ImagePicker();

showImagePicker(BuildContext context) async {
  if (Platform.isIOS) {
    const platform = MethodChannel('imagePickerOptionsChannel');
    try {
      // This method will return 1 if user picked camera and 2 if user picked gallery
      final result = await platform.invokeMethod<int>('showImagePickerOptions');
      switch (result) {
        case 1:
          imagePick(ImageSource.camera);
          break;
        case 2:
          imagePick(ImageSource.gallery);
          break;
      }
    } on PlatformException catch (error) {
      print(error.message);
    }
  } else {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return const CustomButtomSheet_imgPick();
        });
  }
}

imagePick(ImageSource source) async {
  await picker.pickImage(source: source, imageQuality: 100).then((value) {
    if (value != null) {
      _cropImage(File(value.path));
    }
  });
}


Image avatarImg = Image.asset('assets/images/avatar.png');
_cropImage(File imgFile) async {
  final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Edit Photo",
            toolbarColor: kGreenBigButtons,
            toolbarWidgetColor: kWhite,
            statusBarColor: kGreenBigButtons,
            activeControlsWidgetColor: kGreenBigButtons,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: "Edit Photo",
        )
      ]);
  if (croppedFile != null) {
    imageCache.clear();
    avatarImg = Image.file(File(croppedFile.path));
  }
}

Color randomColorsGenerator() {
  Random random = Random();
  return linesColors[random.nextInt(linesColors.length)];
}
