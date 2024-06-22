import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/view/widgets/custom_buttom_sheet_img_pick.dart';

import 'models/data_models/google_server.dart';
import 'models/data_models/server.dart';
import 'models/get_it.dart/key_chain.dart';
import 'models/servers/local_server.dart';

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
    "١١",
    "١٣",
    "١٥",
    "١٧"
  ];

  if (isArabic()) return lines[i].toString();
  return (i + 1).toString();
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
    await uploadImage(croppedFile);
    setImage(Image.file(File(croppedFile.path)));
  }
}


// You should add this property to all buttons to remove splash effect when pressed on iOS
// Determine first if the platform is web, if so, set the splash effect to the default
// Else check again if it's iOS, set it to remove splash
var splashEffect = kIsWeb ? InkSplash.splashFactory : (Platform.isIOS ? NoSplash.splashFactory : InkSplash.splashFactory);

// Firebase Auth
User? currentUser = FirebaseAuth.instance.currentUser;

// Firebase Storage
final storage = FirebaseStorage.instance;
final storageRef = storage.ref();
final profileImagesRef = storageRef.child("profile_images");
final imageRef = profileImagesRef.child("profile_image_${currentUser!.uid}.jpg");

uploadImage(CroppedFile croppedFile) async {
    imageRef.putFile(File(croppedFile.path)).snapshotEvents.listen((taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          LoadingStatusHandler.startLoadingWithProgressAndText(taskSnapshot.bytesTransferred / taskSnapshot.totalBytes, "جاري رفع الصورة");
          break;
        case TaskState.paused:
          LoadingStatusHandler.errorLoading("تم ايقاف رفع الصورة");
          print("UPLOAD PAUSED");
          break;
        case TaskState.success:
          final imageURL = await imageRef.getDownloadURL();
          // print("Image URL is $imageURL");
          await currentUser!.updatePhotoURL(imageURL);
          profileImageURL = imageURL;
          print("SUCCESSFULLY UPLOADED IMAGE");
          LoadingStatusHandler.completeLoadingWithText("تم رفع الصورة بنجاح");
          break;
        case TaskState.canceled:
          LoadingStatusHandler.errorLoading("تم الغاء رفع الصورة");
          print("UPLOAD CANCELED");
          break;
        case TaskState.error:
          LoadingStatusHandler.errorLoading();
          break;
      }
    });


  // LoadingStatusHandler.startLoading();
  // try {
  //   await imageRef.putFile(File(croppedFile.path));
  //
  //   final imageURL = await imageRef.getDownloadURL();
  //   // print("Image URL is $imageURL");
  //   await currentUser!.updatePhotoURL(imageURL);
  //   print("SUCCESSFULLY UPLOADED IMAGE");
  //   LoadingStatusHandler.completeLoadingWithText("تم رفع الصورة بنجاح");
  // } on FirebaseException catch (e) {
  //   LoadingStatusHandler.errorLoading("${e.message}");
  //   print("ERROR UPLOADING IMAGE: ${e.code}, ${e.message}");
  // }
}

// Google Maps API
initializeGoogleMapsAPI() async {
  // loading google map api key
  final json = await rootBundle.loadString('assets/JSON/keys/google_map_key.json');
  // decoding json string
  Map mapObject = jsonDecode(json) as Map;
  // fetching google map api key value
  String apiKey = mapObject['Google_Map_Api'];
  // register google map api key into GET_IT
  GoogleServer APIKEY = GoogleServer(apiKey);
  // GetIt.instance.registerSingleton<GoogleServer>(APIKEY);
  KeyChain.chain.registerSingleton<GoogleServer>(APIKEY);

}

// Our API
String server_url = '';

initializeServerAPI() async {
  // loading server url
  final json = await rootBundle.loadString('assets/JSON/keys/server_url.json');
  // decoding json string
  Map mapObject = jsonDecode(json) as Map;
  // fetching server url  value
  server_url = mapObject['server_url'];
  // register server url into GET_IT
  LocalServer MainServer = LocalServer(server_url);
  KeyChain.chain.registerSingleton<LocalServer>(MainServer, instanceName: 'main-server');
}

// User data
String firstName ='';
String lastName = '';
String? email;
String phoneNumber = '1104149286'; // Without '+20'
String profileImageURL = '';
bool isLoggedIn = false; // Should get from shared preferences