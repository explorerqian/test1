//
import 'package:flutter_trip/model/common_model.dart';
//首页网格模型
class GridNavModel {
  final GradNavItem hotel;
  final GradNavItem flight;
  final GradNavItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? GridNavModel(
            hotel: GradNavItem.fromJson(json['hotel']),
            flight: GradNavItem.fromJson(json['flight']),
            travel: GradNavItem.fromJson(json['travel']),
          )
        : null;
  }
}

class GradNavItem {
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GradNavItem(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

  factory GradNavItem.fromJson(Map<String, dynamic> json) {
    return GradNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }
}
