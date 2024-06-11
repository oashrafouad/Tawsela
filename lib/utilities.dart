import 'dart:io';
import 'package:flutter/foundation.dart';
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

showImagePicker(BuildContext context, Function(Image) setImage) async {
  if (Platform.isIOS) {
    const platform = MethodChannel('imagePickerOptionsChannel');
    try {
      final result = await platform.invokeMethod<int>('showImagePickerOptions');
      switch (result) {
        case 1:
          imagePick(ImageSource.camera, setImage);
          break;
        case 2:
          imagePick(ImageSource.gallery, setImage);
          break;
      }
    } on PlatformException catch (error) {
      print(error.message);
    }
  } else {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return CustomButtomSheet_imgPick(setImage: setImage);
      },
    );
  }
}

imagePick(ImageSource source, Function(Image) setImage) async {
  await picker.pickImage(source: source, imageQuality: 100).then((value) {
    if (value != null) {
      _cropImage(File(value.path), setImage);
    } else {
      print("You didn't pick any image");
    }
  });
}

_cropImage(File imgFile, Function(Image) setImage) async {
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
        lockAspectRatio: false
      ),
      IOSUiSettings(
        title: "Edit Photo",
      )
    ]
  );

  if (croppedFile != null) {
    imageCache.clear();
    setImage(Image.file(File(croppedFile.path)));
  }
}


Color randomColorsGenerator() {
  Random random = Random();
  return linesColors[random.nextInt(linesColors.length)];
}

// You should add this property to all buttons to remove splash effect when pressed on iOS
// Determine first if the platform is web, if so, set the splash effect to the default
// Else check again if it's iOS, set it to remove splash
var splashEffect = kIsWeb ? InkSplash.splashFactory : (Platform.isIOS ? NoSplash.splashFactory : InkSplash.splashFactory);
