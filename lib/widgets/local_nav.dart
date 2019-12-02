import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widgets/web_view.dart';

/**
 * 顶部导航栏
 */
class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  LocalNav(this.localNavList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(6)
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) {
      return null;
    }
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, //平均排列
      children: items,
    );
  }

  _item(BuildContext context, CommonModel model) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>WebView(
                url: model.url,
                statusBarColor: model.statusBarColor,
                hideAppBar: model.hideAppBar,
              )
            ));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          ),
          Text(
            model.title,
            style: TextStyle(
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}
