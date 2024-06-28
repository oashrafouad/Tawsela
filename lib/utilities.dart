import 'dart:convert';
import 'dart:io';
import 'package:appwrite/models.dart'as Appwrite;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/services/API_service.dart';
import 'package:tawsela_app/view/widgets/custom_buttom_sheet_img_pick.dart';
import 'package:appwrite/appwrite.dart';


import 'models/data_models/google_server.dart';
import 'models/data_models/server.dart';
import 'models/get_it.dart/key_chain.dart';

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
// User? currentUser = FirebaseAuth.instance.currentUser;
// String userVerificationId = '';

// Firebase Storage
// final storage = FirebaseStorage.instance;
// final storageRef = storage.ref();
// final profileImagesRef = storageRef.child("profile_images");
// final imageRef = profileImagesRef.child("profile_image_${currentUser!.uid}.jpg");

// uploadImage(CroppedFile croppedFile) async {
//     imageRef.putFile(File(croppedFile.path)).snapshotEvents.listen((taskSnapshot) async {
//       switch (taskSnapshot.state) {
//         case TaskState.running:
//           LoadingStatusHandler.startLoadingWithProgressAndText(taskSnapshot.bytesTransferred / taskSnapshot.totalBytes, "جاري رفع الصورة");
//           break;
//         case TaskState.paused:
//           LoadingStatusHandler.errorLoading("تم ايقاف رفع الصورة");
//           print("UPLOAD PAUSED");
//           break;
//         case TaskState.success:
//           final imageURL = await imageRef.getDownloadURL();
//           // print("Image URL is $imageURL");
//           await currentUser!.updatePhotoURL(imageURL);
//           profileImageURL = imageURL;
//           print("SUCCESSFULLY UPLOADED IMAGE");
//           await LoadingStatusHandler.completeLoadingWithText("تم رفع الصورة بنجاح");
//           break;
//         case TaskState.canceled:
//           LoadingStatusHandler.errorLoading("تم الغاء رفع الصورة");
//           print("UPLOAD CANCELED");
//           break;
//         case TaskState.error:
//           LoadingStatusHandler.errorLoading();
//           break;
//       }
//     });


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
// }

// Appwrite
Account? account;
Storage? storage;
Databases? databases;

String userId = '';
String bucketId = '667d6b95000327ce05c8';

initializeAppwrite() {
  Client client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('667d6094000ed16eed70');

  account = Account(client);
  storage = Storage(client);
  databases = Databases(client);

}

uploadImage(CroppedFile croppedFile) async {
  final fileId = ID.unique();
      LoadingStatusHandler.startLoadingWithText("جاري رفع الصورة");
  try {
    final file = await storage!.createFile(
      bucketId: bucketId,
      fileId: fileId,
      file: InputFile.fromPath(path: croppedFile.path, filename: 'profile_image_$userId.jpg'),
    );
    // print(file.name);
    print("SUCCESSFULLY UPLOADED IMAGE");

    await storage!.getFileDownload(bucketId: bucketId, fileId: fileId).then((bytes) async {
    print("SUCCESSFULLY GOT IMAGE");
      final tempPath = (await getTemporaryDirectory()).path;
      final tempFile = File('$tempPath/profileImage.jpg');
      // final file = await File('$tempPath/profileImage.jpg').create();
    // print("Bytes: $bytes");
      await tempFile.writeAsBytes(bytes);
    print("SUCCESSFULLY WROTE IMAGE");

      // convert to fileimage
      // profileImage = FileImage(tempFile);

      base64Image = base64Encode(bytes);
    print("SUCCESSFULLY ENCODED IMAGE");
      // print("base: $base64Image");
      // print length of base64 image
      print("base64 length: ${base64Image.length}");

      // try {
      //   await databases!.createDocument(
      //     databaseId: '667ed11000020e17c007',
      //     collectionId: '667ed13b000f6bb0b7b8',
      //     documentId: userId,
      //     data: {
      //       "base64Image": base64Image
      //     },
      //   );
      // } on AppwriteException catch (e) {
      //   print('Error uploading image to appwrite: $e');
      // }


      // create memoryimage from bytes
      profileImage = MemoryImage(bytes);
    });

    // await currentUser!.updatePhotoURL(imageURL);
    // profileImageURL = imageURL;
    // print("SUCCESSFULLY UPLOADED IMAGE");
    LoadingStatusHandler.completeLoadingWithText("تم رفع الصورة بنجاح");
  } on AppwriteException catch (e) {
    LoadingStatusHandler.errorLoading("$e");
    print("ERROR UPLOADING IMAGE: $e");
  }
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
  // print(server_url);
  // register server url into GET_IT
}

// Shared preferences
SharedPreferences? sharedPreferences;

// User data
String firstName = '';
String lastName = '';
String phoneNumber = '1104149286'; // Without '+20'
// String phoneNumber = ''; // Without '+20'
// FileImage profileImage = Image.asset('assets/images/profile_image.png') as FileImage;

MemoryImage profileImage = MemoryImage(Uint8List(0));
String base64Image = '';
// initialize empty fileimage
// FileImage profileImage = FileImage(File('assets/images/avatar.png'));
bool isLoggedIn = false; // Should get from shared preferences
bool isDriver=false; // to check if the user is a driver or passenger

updateDataToSharedPrefs() async { //that will update the shared preferences values
 // print("1. $isLoggedIn");
  await sharedPreferences!.setString('firstName', firstName);
  await sharedPreferences!.setString('lastName', lastName);
  await sharedPreferences!.setString('phoneNumber', phoneNumber);
  await sharedPreferences!.setString('base64Image', base64Image);
  await sharedPreferences!.setBool('isLoggedIn', isLoggedIn);
  await sharedPreferences!.setBool('isDriver', isDriver);
  print('LOCAL VARIABLES:');
  print ('First Name: $firstName');
  print ('Last Name: $lastName');
  print ('Phone Number: $phoneNumber');
  print ('Base64 Image: $base64Image');
  print ('Is Logged In: $isLoggedIn');
  print ('Is Driver: $isDriver');
  print('-------------------');
  print("SHAREDPREF:");
  print ('First Name: ${await sharedPreferences!.getString('firstName')}');
  print ('Last Name: ${await sharedPreferences!.getString('lastName')}');
  print ('Phone Number: ${await sharedPreferences!.getString('phoneNumber')}');
  print ('Base64 Image: ${await sharedPreferences!.getString('base64Image')}');
  print ('Is Logged In: ${await sharedPreferences!.getBool('isLoggedIn')}');
  print ('Is Driver: ${await sharedPreferences!.getBool('isDriver')}');
}

initValues() async {
  firstName = await sharedPreferences!.getString('firstName') ?? '';
  lastName = await sharedPreferences!.getString('lastName') ?? '';
  phoneNumber = await sharedPreferences!.getString('phoneNumber') ?? '';
  base64Image = await sharedPreferences!.getString('base64Image') ?? '';
  print('First name: $firstName');
  print('Last name: $lastName');
  print('Phone number: $phoneNumber');
  print('Base64 image: $base64Image');

}

setProfileImage() {
  if (base64Image != '') {
    profileImage = MemoryImage(base64Decode(base64Image));
  }
}

resetData() async { // use when user logs out
  await sharedPreferences!.clear();
}

getAllUserInfoAndAssignToVariables({required String phoneNumber}) async {
  try {
    final userInfo = await ApiService.getUserInfo(phoneNumber: phoneNumber);
    userInfo.forEach((key, value) {
      if (key == 'f_name') {
        firstName = value;
      } else if (key == 'l_name') {
        lastName = value;
      } else if (key == 'phone_num') {
        phoneNumber = value;
      }
      // else if (key == 'profile_image_url') {
      //   profileImageURL = value;
      // }
    });
    //GET DOCUMENT


    // get profile image from firebase (temp)
    //TODO: edit this after we can get the profile image from our server
    // profileImageURL = currentUser!.photoURL!;

    // Appwrite.Document? document;
    // try {
    //   document = await databases!.getDocument(
    //       databaseId: '667ed11000020e17c007',
    //       collectionId: '667ed13b000f6bb0b7b8',
    //       documentId: userId
    //   );
    // } on AppwriteException catch(e) {
    //   print(e);
    // }
    // base64Image = document!.data['base64Image'];


    // print("assigned");
    print('DATA FROM SERVER:');
    print(userInfo);
  } catch (error) {
    print('Error fetching user info: $error');
  }
}
