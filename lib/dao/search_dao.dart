import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;


// const SEARCH_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=](https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchDao {
  static Future<SearchModel> getData(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return SearchModel.fromJson(result);
    } else {
      throw Exception('Failed to load homePage.json');
    }
  }
}
