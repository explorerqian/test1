import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'dart:convert';

import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/widgets/grad_nav.dart';
import 'package:flutter_trip/widgets/loading_container.dart';
import 'package:flutter_trip/widgets/local_nav.dart';
import 'package:flutter_trip/widgets/sale_box.dart';
import 'package:flutter_trip/widgets/search_bar.dart';
import 'package:flutter_trip/widgets/sub_nav.dart';
import 'package:flutter_trip/widgets/web_view.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imgUrl = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574684597363&di=aa6150561041b0f4f484cc07a6705a4b&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20160411%2F977c60aa2b364168ae984806a619bf94_th.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574684597362&di=867c781e2ad05b2213e50d3bf6129a17&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn10116%2F400%2Fw1200h800%2F20190404%2F25a5-hvcmeuy5799568.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574684597362&di=b1a831d0e4e4e9862b008cd74eef5787&imgtype=0&src=http%3A%2F%2Fpic59.nipic.com%2Ffile%2F20150122%2F20259612_193322171000_2.jpg"
  ];
  double appBarAlpha = 0;

  String resultString = '';
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;
  List<CommonModel> bannerList = [];
  bool _loading = true;
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
//    print(appBarAlpha);
  }

  @override
  void initState() {
    _handleRefush();
    super.initState();
  }

//  _loadData(){
//    HomeDao.getHomeData().then((item){
//      setState(() {
//        resultString = json.encode(item);
//      });
//    }).catchError((e){
//      resultString.e.toString();
//    });
//  }
  Future<Null> _handleRefush() async {
    try {
      HomeModel model = await HomeDao.getHomeData();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              //移除listview的默认padding
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _handleRefush,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar,
          ],
        ),
      ),
    );
  }

  Widget get _listView{
    return ListView(
      children: <Widget>[
       _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(this.localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GradNav(gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(this.subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SaleBox(this.salesBox),
        ),

//        Container(
//          height: 900,
//          child: ListTile(
//            title: Text(resultString),
//          ),
//        )
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
            height: appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }
  _jumpToSearch(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage(
      hint: SEARCH_BAR_DEFAULT_TEXT,
    )));
  }
  _jumpToSpeak(){

  }
  // 滚动图banner
  Widget get _banner{
    return  Container(
      height: 150,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                      WebView(url: bannerList[index].url,
                        title: bannerList[index].title,
                        hideAppBar: bannerList[index].hideAppBar,
                      )
                  )
              );
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(), //轮播图底部的圈圈
      ),
    );
  }
}
