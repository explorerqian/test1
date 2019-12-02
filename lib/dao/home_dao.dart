import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/model/home_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class HomeDao {
  static Future<HomeModel> getHomeData() async {
    final response = await http.get('http://www.devio.org/io/flutter_app/json/home_page.json');
    //    Dio dio = Dio();
    // Response response = await dio.get('http://www.devio.org/io/flutter_app/json/home_page.json');
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load homePage.json');
    }
  }
}
