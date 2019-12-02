import 'package:flutter/material.dart';
//加载进度条组件
class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;  //是否在加载
  final bool cover;

  LoadingContainer({@required this.child, @required this.isLoading, this.cover = false});

  @override
  Widget build(BuildContext context) {
    return !cover?!isLoading?child:_loadingView:Stack(
      children: <Widget>[
        child,isLoading?_loadingView:null
      ],
    );
  }
  Widget get _loadingView{
    return Center(
      child: CircularProgressIndicator(),   //圆形加载样式
    );
  }
}
