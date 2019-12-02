import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widgets/web_view.dart';

class GradNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  GradNav(this.gridNavModel);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.transparent,  //透明背景色
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,  //裁切
      child: Column(
        children: _gridNavItems(context),
      )
    );

  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) {
      return items;
    }
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }
  //一行，包括一个大的，两个小的
  _gridNavItem(BuildContext context, GradNavItem gradNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gradNavItem.mainItem));
    items.add(_doubleItem(context, gradNavItem.item1, gradNavItem.item2));
    items.add(_doubleItem(context, gradNavItem.item3, gradNavItem.item4));
    //将组件放入Expand中，将其撑开
    List<Widget> expandItems = [];
    items.forEach((item){
      expandItems.add(Expanded(child: item,flex: 1));
    });
    Color startColor = Color(int.parse('0xff'+gradNavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gradNavItem.endColor));

    return Container(
      height: 88,
      margin: first?null:EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(colors: [startColor,endColor])
      ),
      child: Row(
        children:expandItems,
      ),
    );
  }

  // 最左侧大的一个
  _mainItem(BuildContext context, CommonModel model) {
    return _inkWellItem(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 120,
              alignment: AlignmentDirectional.bottomEnd, //放到底部
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )

          ],
        ),
        model);
  }
  
  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        //垂直最大化撑开
        Expanded(
          child: _item(context,topItem,true),
        ),
        Expanded(
          child: _item(context,bottomItem,false),
        )
      ],
    );
  }
  // 右侧小的格子widget
  _item(BuildContext context, CommonModel model, bool isFirst
      ) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(  //让他水平方向展开
      widthFactor: 1,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            left: borderSide,
            bottom: isFirst ? borderSide : BorderSide.none,
          )),
          child: _inkWellItem(
              context,
              Center(
                child: Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              model)),
    );
  }

  //跳转页面的方法
  _inkWellItem(BuildContext context, Widget widget, CommonModel model) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: model.url,
                      title: model.title,
                      statusBarColor: model.statusBarColor,
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
