import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];
class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid =false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  @override
  void initState() {
    bool exiting =false;
    super.initState();
    flutterWebviewPlugin.close();
    // 设置url监听
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {});
    // 状态变化监听
    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url) && !exiting) {
                if (widget.backForbid) {
                  flutterWebviewPlugin.launch(widget.url);
                } else {
                  Navigator.pop(context);
                  exiting = true;
                }
              }
          break;
        default:
          break;
      }
    });
    // 异常监听
    _onHttpError = flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error){print(error);});


  }


  // 判断是否在白名单

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backButtonColor;
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    if(statusBarColorStr=='ffffff'){
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColorStr)),backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(   //初始化界面
                color: Colors.white,
                child: Center(
                  child: Text('loading....'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  _appBar(Color backgroundColor,Color backButtonColor){
    if(widget.hideAppBar??false){
      return Container(
        color: backButtonColor,
        height: 30,
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
      color: backgroundColor,
      child: FractionallySizedBox(
        widthFactor: 1,  // 宽度撑满
        child: Stack(
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                 child: Text(widget.title??'',
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: 20
                  ),
                 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
//const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];
//
//class WebView extends StatefulWidget {
//  String url;
//  final String statusBarColor;
//  final String title;
//  final bool hideAppBar;
//  final bool backForbid;
//
//  WebView(
//      {this.url,
//        this.statusBarColor,
//        this.title,
//        this.hideAppBar,
//        this.backForbid = false}) {
//    if (url != null && url.contains('ctrip.com')) {
//      //fix 携程H5 http://无法打开问题
//      url = url.replaceAll("http://", 'https://');
//    }
//  }
//
//  @override
//  _WebViewState createState() => _WebViewState();
//}
//
//class _WebViewState extends State<WebView> {
//  final webviewReference = FlutterWebviewPlugin();
//  StreamSubscription<String> _onUrlChanged;
//  StreamSubscription<WebViewStateChanged> _onStateChanged;
//  StreamSubscription<WebViewHttpError> _onHttpError;
//  bool exiting = false;
//
//  @override
//  void initState() {
//    super.initState();
//    webviewReference.close();
//    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
//    _onStateChanged =
//        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
//          switch (state.type) {
//            case WebViewState.startLoad:
//              if (_isToMain(state.url) && !exiting) {
//                if (widget.backForbid) {
//                  webviewReference.launch(widget.url);
//                } else {
//                  Navigator.pop(context);
//                  exiting = true;
//                }
//              }
//              break;
//            default:
//              break;
//          }
//        });
//    _onHttpError =
//        webviewReference.onHttpError.listen((WebViewHttpError error) {
//          print(error);
//        });
//  }
//
//  _isToMain(String url) {
//    bool contain = false;
//    for (final value in CATCH_URLS) {
//      if (url?.endsWith(value) ?? false) {
//        contain = true;
//        break;
//      }
//    }
//    return contain;
//  }
//
//  @override
//  void dispose() {
//    _onStateChanged.cancel();
//    _onUrlChanged.cancel();
//    _onHttpError.cancel();
//    webviewReference.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
//    Color backButtonColor;
//    if (statusBarColorStr == 'ffffff') {
//      backButtonColor = Colors.black;
//    } else {
//      backButtonColor = Colors.white;
//    }
//    return Scaffold(
//      body: Column(
//        children: <Widget>[
//          _appBar(
//              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
//          Expanded(
//              child: WebviewScaffold(
//                userAgent: 'null',//防止携程H5页面重定向到打开携程APP ctrip://wireless/xxx的网址
//                url: widget.url,
//                withZoom: true,
//                withLocalStorage: true,
//                hidden: true,
//                initialChild: Container(
//                  color: Colors.white,
//                  child: Center(
//                    child: Text('Waiting...'),
//                  ),
//                ),
//              ))
//        ],
//      ),
//    );
//  }
//
//  _appBar(Color backgroundColor, Color backButtonColor) {
//    if (widget.hideAppBar ?? false) {
//      return Container(
//        color: backgroundColor,
//        height: 30,
//      );
//    }
//    return Container(
//      color: backgroundColor,
//      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
//      child: FractionallySizedBox(
//        widthFactor: 1,
//        child: Stack(
//          children: <Widget>[
//            GestureDetector(
//              onTap: () {
//                Navigator.pop(context);
//              },
//              child: Container(
//                margin: EdgeInsets.only(left: 10),
//                child: Icon(
//                  Icons.close,
//                  color: backButtonColor,
//                  size: 26,
//                ),
//              ),
//            ),
//            Positioned(
//              left: 0,
//              right: 0,
//              child: Center(
//                child: Text(
//                  widget.title ?? '',
//                  style: TextStyle(color: backButtonColor, fontSize: 20),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
