import 'dart:convert';

import 'package:flutter/services.dart';

class KeyChain {
  static String? main_server_url;
  static String? google_server_key;

  static Future<void> Key_Chain_Initialize() async {
    /** Google server part */
    var json =
        await rootBundle.loadString('assets/JSON/keys/google_map_key.json');
    // decoding json string
    Map mapObject = jsonDecode(json) as Map;
    // fetching google map api key value
    String apiKey = mapObject['Google_Map_Api'];
    // initializing google server api key
    KeyChain.google_server_key = apiKey;

    /**Main Server part */
    json = await rootBundle.loadString('assets/JSON/keys/server_url.json');
    // decoding json string
    mapObject = jsonDecode(json) as Map;
    // fetching server url  value
    String server_url = mapObject['server_url'];
    // initializing main server url
    KeyChain.main_server_url = server_url;
  }
}
