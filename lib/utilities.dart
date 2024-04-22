import 'dart:io';
import 'package:flutter/material.dart';
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

// askForPermission() async {
//   Map<Permission, PermissionStatus> statues = await [
//     Permission.storage,
//     Permission.camera,
//   ].request();
//   statues[Permission.storage]!.isGranted &&
//           statues[Permission.camera]!.isGranted
//       ? print('granted')
//       : print('not granted');
// }

final picker = ImagePicker();

void showImagePicker(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return const CustomButtomSheet_imgPick();
      });
}

imagePick(ImageSource source) async {
  await picker.pickImage(source: source, imageQuality: 100).then((value) {
    if (value != null) {
      _cropImage(File(value.path));
    }
  });
}

File? imageFile;

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
            toolbarTitle: "Image Cropper",
            toolbarColor: kGreenBigButtons,
            toolbarWidgetColor: kWhite,
            statusBarColor: kGreenBigButtons,
            activeControlsWidgetColor: kGreenBigButtons,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: "Image Cropper",
        )
      ]);
  if (croppedFile != null) {
    imageCache.clear();
    imageFile = File(croppedFile.path);
  }
}

Color randomColorsGenerator() {
  Random random = Random();
  return linesColors[random.nextInt(linesColors.length)];
}