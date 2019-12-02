import 'package:flutter/material.dart';

/**
 *上拉刷新，下拉加载
 */

class RefreshDemo extends StatefulWidget {
  @override
  _RefreshDemoState createState() => _RefreshDemoState();
}

class _RefreshDemoState extends State<RefreshDemo> {
  List<String> cityLists = ['北京','上海','北京','上海','北京','上海','北京','上海','上海','北京','上海','北京','上海','北京','上海','北京','上海','上海'];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // 添加监听
    _controller.addListener((){
      if(_controller.position.pixels == _controller.position.maxScrollExtent){ //滚动到底部
//        print(_controller.position.pixels);
        _reloadList();
      }
    });

    super.initState();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  _reloadList() async{
    await Future.delayed(Duration(milliseconds: 200));
    print(111);
    setState(() {
      //复制数组
      List<String> list = List<String>.from(cityLists);
      list.addAll(cityLists);
      cityLists = list;
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('上拉刷新下拉加载'),),
      body: RefreshIndicator(   //在ListView外层包一层RefreshIndicator即可实现下拉刷新
        onRefresh: _handleResfesh,  //必须实现的future刷新方法
        child:ListView(
          controller: _controller,
          children: _buildLists(),
        ),
      )

    );
  }

  Future<Null> _handleResfesh() async {
    await Future.delayed(Duration(seconds:2));
    setState(() {
      cityLists = cityLists.reversed.toList();
    });
    return null;
  }

  List<Widget> _buildLists(){
    List<Widget> list = [];
    return cityLists.map((city)=>_buildItem(city)).toList();
  }

  Widget _buildItem(String cityName){
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 3),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(cityName),
    );
  }
}
