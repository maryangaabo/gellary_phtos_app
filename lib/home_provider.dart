import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:gellay/image_mode.dart';

class HomeProvider {
  getImages() async {
    try {
      var response = await rootBundle.loadString('assets/data/data.json');

      List data = jsonDecode(response);
      return data.map((e) => ImageModel.fromjson(e)).toList();
    } catch (e) {
      log(e.toString(), name: "Get Images error");
    }
  }
}
