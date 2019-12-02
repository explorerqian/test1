import 'package:flutter/material.dart';
import 'package:flutter_trip/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  final String hint;

  SearchPage({this.hint});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            SearchBar(
              hint: '请输入搜索内容',
              leftButtonClick: (){
                Navigator.pop(context);
              },
              hideLeft: true,
              defaultText: '123',
              onChanged: onTextChange(),
            )
          ],
        ),
      )
    );
  }
  onTextChange(){

  }
}