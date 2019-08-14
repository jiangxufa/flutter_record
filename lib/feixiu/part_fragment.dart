import 'package:flutter/material.dart';
import 'package:flutter_demo/demo9_page_view.dart';
import 'package:flutter_demo/feixiu/part_page.dart';

class PageFragment extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  PageFragment(this._scaffoldKey);

  @override
  State<StatefulWidget> createState() {
    return PageFragmentState();
  }
}

class PageFragmentState extends State<PageFragment>
    with SingleTickerProviderStateMixin {
  List<TabTitle> tabList;
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  var currentPage = 0;
  var isPageCanChanged = true;
  var pageDatas;

  @override
  void initState() {
    super.initState();
    initTabData();
    mTabController = TabController(
      length: tabList.length,
      vsync: this,
    );
    mTabController.addListener(() {
      //TabBar的监听
      if (mTabController.indexIsChanging) {
        //判断TabBar是否切换
        print(mTabController.index);
        onPageChange(mTabController.index, p: mPageController);
      }
    });
    pageDatas = List.generate(20, (int index){
      return PartPage();
    }).toList();
  }

  initTabData() {
    tabList = [
      new TabTitle('我常用的', 10),
      new TabTitle('空调', 0),
      new TabTitle('冰箱', 1),
      new TabTitle('下水管道', 2),
      new TabTitle('下水道', 3),
      new TabTitle('美文', 4),
      new TabTitle('科技', 5),
      new TabTitle('财经', 6),
      new TabTitle('时尚', 7)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("标题"),
//      ),
      key: widget._scaffoldKey,
//      bottomSheet: Container(height: 100,color: Colors.lightGreen,),
      body: Column(
        children: <Widget>[
          Container(
            color: new Color(0xfff4f5f6),
            height: 38.0,
            child: TabBar(
              isScrollable: true,
              //是否可以滚动
              controller: mTabController,
              labelColor: Colors.lightGreen,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tabList.map((item) {
                return Tab(
                  text: item.title,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: tabList.length,
              onPageChanged: (index) {
                if (isPageCanChanged) {
                  //由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                  onPageChange(index);
                }
              },
              controller: mPageController,
              itemBuilder: (BuildContext context, int index) {
                return pageDatas[index];
              },
            ),
          )
        ],
      ),
    );
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //判断是哪一个切换
      isPageCanChanged = false;
      await mPageController.animateToPage(index,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index); //切换Tabbar
    }
  }
}
