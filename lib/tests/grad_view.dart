import 'package:flutter/material.dart';

/**
 * 网格GridView
 */
const CITY_LIST = ['北京','上海','北京','上海','北京','上海','北京','上海','上海','北京','上海','北京','上海','北京','上海','北京','上海','上海'];
class WanggeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('网格布局'),),
      body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 0.5,//列的间隔
          mainAxisSpacing: 0.5,// 行间隔
          childAspectRatio: 1,   //宽高比例
          children: _buildCityList()
      ),
    );
  }
  List<Widget> _buildCityList(){
    return CITY_LIST.map((cityName)=>_item(cityName)).toList();
  }

  Widget _item(String cityName) {
    return Container(
//      height: 170,
//      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(color: Colors.lightBlue),
      alignment: Alignment.center,
      child: Text(cityName),
    );
  }
}
