// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to the app`
  String get title {
    return Intl.message(
      'Welcome to the app',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Tawsela 🚌`
  String get appName {
    return Intl.message(
      'Tawsela 🚌',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Tawseela will help you go anywhere in`
  String get descriptions {
    return Intl.message(
      'Tawseela will help you go anywhere in',
      name: 'descriptions',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verifyCode {
    return Intl.message(
      'Verification Code',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `E-mail (otpinal)`
  String get email {
    return Intl.message(
      'E-mail (otpinal)',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get phoneNum {
    return Intl.message(
      'Mobile Number',
      name: 'phoneNum',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the following information to create \nyour account`
  String get passengerSignUpTitle {
    return Intl.message(
      'Fill in the following information to create \nyour account',
      name: 'passengerSignUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Microbus Guide Line`
  String get MicrobusGuideStationAppBarTitle {
    return Intl.message(
      'Microbus Guide Line',
      name: 'MicrobusGuideStationAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `You will receive a message containing the verification code\nPlease write it here.`
  String get smsVerificationScreenTitle {
    return Intl.message(
      'You will receive a message containing the verification code\nPlease write it here.',
      name: 'smsVerificationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `verifycode`
  String get verifycode {
    return Intl.message(
      'verifycode',
      name: 'verifycode',
      desc: '',
      args: [],
    );
  }

  /// `Sing in with Facebook`
  String get singInFaceBook {
    return Intl.message(
      'Sing in with Facebook',
      name: 'singInFaceBook',
      desc: '',
      args: [],
    );
  }

  /// `Sing in with Google`
  String get singInGoogle {
    return Intl.message(
      'Sing in with Google',
      name: 'singInGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sing in with Apple`
  String get singInApple {
    return Intl.message(
      'Sing in with Apple',
      name: 'singInApple',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Tawsela will help you go anywhere in Faiyum with ease, choose the place you want to go and the application will select the most suitable transportation for you`
  String get welcomeMsg {
    return Intl.message(
      'Tawsela will help you go anywhere in Faiyum with ease, choose the place you want to go and the application will select the most suitable transportation for you',
      name: 'welcomeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Send code again`
  String get sendCodeAgain {
    return Intl.message(
      'Send code again',
      name: 'sendCodeAgain',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImg {
    return Intl.message(
      'Upload Image',
      name: 'uploadImg',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get signUp {
    return Intl.message(
      'Register',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Personal Image`
  String get personalImage {
    return Intl.message(
      'Personal Image',
      name: 'personalImage',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message(
      'Show All',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Places`
  String get favPlaces {
    return Intl.message(
      'Favorite Places',
      name: 'favPlaces',
      desc: '',
      args: [],
    );
  }

  /// `Microbuses Lines Guide`
  String get microbusesLinesGuide {
    return Intl.message(
      'Microbuses Lines Guide',
      name: 'microbusesLinesGuide',
      desc: '',
      args: [],
    );
  }

  /// `Click to select this location`
  String get clickSelectThisLocation {
    return Intl.message(
      'Click to select this location',
      name: 'clickSelectThisLocation',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Where You want to go?`
  String get whereUwantoGo {
    return Intl.message(
      'Where You want to go?',
      name: 'whereUwantoGo',
      desc: '',
      args: [],
    );
  }

  /// `Hawatem`
  String get hawatam {
    return Intl.message(
      'Hawatem',
      name: 'hawatam',
      desc: '',
      args: [],
    );
  }

  /// `Open a driver account by submitting Some\nadditional information`
  String get signUpDriverMsg {
    return Intl.message(
      'Open a driver account by submitting Some\nadditional information',
      name: 'signUpDriverMsg',
      desc: '',
      args: [],
    );
  }

  /// `License Image`
  String get licenseImg {
    return Intl.message(
      'License Image',
      name: 'licenseImg',
      desc: '',
      args: [],
    );
  }

  /// `ID Card`
  String get idCardImg {
    return Intl.message(
      'ID Card',
      name: 'idCardImg',
      desc: '',
      args: [],
    );
  }

  /// `Choose On Map`
  String get chooseOnMap {
    return Intl.message(
      'Choose On Map',
      name: 'chooseOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Recently Visited`
  String get recentlyVisited {
    return Intl.message(
      'Recently Visited',
      name: 'recentlyVisited',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get favourite {
    return Intl.message(
      'Favourite',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `Specify a location to pick up passengers`
  String get specifyASpecificLocationToPickUpPassengers {
    return Intl.message(
      'Specify a location to pick up passengers',
      name: 'specifyASpecificLocationToPickUpPassengers',
      desc: '',
      args: [],
    );
  }

  /// `To edit the name and profile picture, contact technical support`
  String get ToEditTheNameAndProfilePictureContactTechnicalSupport {
    return Intl.message(
      'To edit the name and profile picture, contact technical support',
      name: 'ToEditTheNameAndProfilePictureContactTechnicalSupport',
      desc: '',
      args: [],
    );
  }

  /// `Switch to driver mode`
  String get switchDriverMode {
    return Intl.message(
      'Switch to driver mode',
      name: 'switchDriverMode',
      desc: '',
      args: [],
    );
  }

  /// `Switch to passenger mode`
  String get switchPassengermode {
    return Intl.message(
      'Switch to passenger mode',
      name: 'switchPassengermode',
      desc: '',
      args: [],
    );
  }

  /// `Trips`
  String get numberoftrips {
    return Intl.message(
      'Trips',
      name: 'numberoftrips',
      desc: '',
      args: [],
    );
  }

  /// `Trip`
  String get trip {
    return Intl.message(
      'Trip',
      name: 'trip',
      desc: '',
      args: [],
    );
  }

  /// `Trip Log`
  String get tripLog {
    return Intl.message(
      'Trip Log',
      name: 'tripLog',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
