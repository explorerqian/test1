import 'package:flutter/material.dart';

const CITY_NAMES = {
  '北京': ['东城区','朝阳区'],
  '苏州':['吴中区','园区']
};
/**
 * 下拉列表
 */
class ExpansionTest extends StatefulWidget {
  @override
  _ExpansionTestState createState() => _ExpansionTestState();
}

class _ExpansionTestState extends State<ExpansionTest> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('下拉列表'),),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
    );
  }
  List<Widget> _buildList(){
    List<Widget> widgets = [];
    CITY_NAMES.keys.forEach((key){
      widgets.add(_item(key, CITY_NAMES[key]));
    });
    return widgets;
  }
  Widget _item(String city ,List<String> subCities){
    return ExpansionTile(
      title: Text(city),
      children: subCities.map((subCity)=>_buildSub(subCity)).toList(),
    );
  }
  Widget _buildSub(String subCity){

    return FractionallySizedBox(
      widthFactor:1,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(color: Colors.lightBlue),
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(subCity),
        )
      ),
    );
  }
}
