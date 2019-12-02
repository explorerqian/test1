import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widgets/web_view.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  SubNav(this.subNavList);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: _subNavItems(context));
  }

  _subNavItems(BuildContext context) {
    if (subNavList == null) {
      return null;
    }
    List<Widget> list = [];
    subNavList.forEach((item) {
      list.add(_subNavItem(context, item));
    });
    //计算一行的数量
    int count = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //平均排列
            children: list.sublist(0, count),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //平均排列
            children: list.sublist(count, subNavList.length),
          ),
        ),

      ],
    );
  }

  _subNavItem(BuildContext context, CommonModel model) {
    return _InkWellItem(
        context,
        Container(
          height: 50,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Image.network(
                  model.icon,
                  height: 18,
                  width: 18,
                ),
              ),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
        model);
  }

  _InkWellItem(BuildContext context, Widget widget, CommonModel model) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: model.url,
                        hideAppBar: model.hideAppBar,
                        title: model.title,
                      )));
        },
        child: widget,
      ),
    );
  }
}
