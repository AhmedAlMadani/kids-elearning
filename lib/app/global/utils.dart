import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
//...
Future<List<dynamic>> parseJsonFromAssets(String file) async {
  String assetsPath = "assets/data/$file.json";
  print('--- Parse json from: $assetsPath');
  var data = json.decode(await rootBundle.loadString(assetsPath));
  return data;
}