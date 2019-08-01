import 'package:flutter/material.dart';
import 'package:flutter_demo/demo0_list.dart';
import 'package:flutter_demo/demo1_layout.dart';
import 'package:flutter_demo/demo2_state_manager.dart';
import 'package:flutter_demo/demo3_response.dart';
import 'package:flutter_demo/demo4_navigator.dart';

class ListData {
  String title;
  Widget rootLayout;

  ListData(this.title, this.rootLayout);

  void pushLayout(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return rootLayout;
    }));
  }

  static List<ListData> createDatas() {
    var datas = <ListData>[];
    datas.add(ListData("使用RandonWord的列表和收藏", RandomWords()));
    datas.add(ListData("关于布局控件的使用(注意图片的显示fitBox和加载)", Demo1Layout()));
    datas.add(ListData("关于state的管理Demo", StateDemoLayout()));
    datas.add(ListData("更改小部件以响应输入", ResponseLayout()));
    datas.add(ListData("关于导航的Demo", NavigatorLayout()));
    return datas;
  }

  static Widget createTitleLayout(String title,Widget content){
    return  Align(
      child: Column(
        children: <Widget>[
          Text(title),
          content
        ],
      ),
    );
  }

  static pushPage(BuildContext context,Widget widget){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return widget;
      }));
  }
}


///StatefulWidget和State类。
class HomeLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}
class HomeState extends State<HomeLayout> {

  ///在Dart语言中使用下划线前缀标识符，会强制其变成私有的
  final _datas = ListData.createDatas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表演示"),
      ),
      body:  ListView.builder(itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text(_datas[index].title),onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return _datas[index].rootLayout;
          }));
        });
      },itemCount: _datas.length,),
    );
  }

}
