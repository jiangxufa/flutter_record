import 'package:flutter/material.dart';
import 'package:flutter_demo/demo0_list.dart';
import 'package:flutter_demo/demo10_page_%20parallax.dart';
import 'package:flutter_demo/demo11_bottom_sheet.dart';
import 'package:flutter_demo/demo12_animat_y.dart';
import 'package:flutter_demo/demo13_bottom_sheet_part.dart';
import 'package:flutter_demo/demo14_car_animat.dart';
import 'package:flutter_demo/demo1_layout.dart';
import 'package:flutter_demo/demo2_state_manager.dart';
import 'package:flutter_demo/demo3_response.dart';
import 'package:flutter_demo/demo4_navigator.dart';
import 'package:flutter_demo/demo5_animat.dart';
import 'package:flutter_demo/demo6_drawer.dart';
import 'package:flutter_demo/demo7_SliverAppBar.dart';
import 'package:flutter_demo/demo7_launcher.dart';
import 'package:flutter_demo/demo8_d.dart';
import 'package:flutter_demo/demo9_page_view.dart';
import 'package:flutter_demo/feixiu/add_page.dart';
import 'package:flutter_demo/feixiu/bottom_car_layout.dart';
import 'package:flutter_demo/feixiu/feixiu_page.dart';
import 'package:flutter_demo/feixiu/part_car_page.dart';
import 'package:flutter_demo/feixiu/part_fragment.dart';
import 'package:flutter_demo/feixiu/part_page.dart';

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
    datas.add(ListData("关于动画的Demo", AnimationLayout()));
    datas.add(ListData("关于drawer的Demo", DrawerLayoutDemo()));
    datas.add(ListData("浮动应用栏", SliverAppBarDemo()));
    datas.add(ListData("封装控件", FeixiuPage()));
    datas.add(ListData("launcher", LauncherPage()));
    datas.add(ListData("launcher", HahaPage()));
    datas.add(ListData("PartPage", PartPage()));
    datas.add(ListData("PageApp", PageApp()));
    datas.add(ListData("PageFragment", PageFragment(null,(){})));
    datas.add(ListData("PageDemo", PageDemo()));
    datas.add(ListData("BottomSheetPage", BottomSheetPage()));
    datas.add(ListData("PartCarPage", PartCarPage()));
    datas.add(ListData("AnimatY", TranslateAnimation()));
    datas.add(ListData("AnimatY", AnimatY()));
    datas.add(ListData("PartBottomSheetPage", PartBottomSheetPage()));
    datas.add(ListData("CarAnimatDemo", CarAnimatDemo()));
    datas.add(ListData("CarAnimatDemoState1", CarAnimatDemo1()));
    datas.add(ListData("BottomCarLayout", BottomCarLayout()));
    datas.add(ListData("AddPage", AddPage()));
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
