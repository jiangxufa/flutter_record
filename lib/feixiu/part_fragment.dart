import 'package:flutter/material.dart';
import 'package:flutter_demo/demo9_page_view.dart';
import 'package:flutter_demo/feixiu/part_page.dart';
import 'package:flutter_demo/feixiu/widget/part_item.dart';

class PageFragment extends StatefulWidget {
  GlobalKey<ScaffoldState> _scaffoldKey;
 final VoidCallback onPressed;
 final AddReduceClickListener listener;

  PageFragment(this._scaffoldKey, this.onPressed,{this.listener});

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
    pageDatas = List.generate(20, (int index) {
      return PartPage(listener: widget.listener,);
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
      key: widget._scaffoldKey,
      body: Column(
        children: <Widget>[
          _buildTabContainer(),
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

  _buildTabContainer() => Container(
        height: 38,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TabBar(
                isScrollable: true,
                //是否可以滚动
                controller: mTabController,
                labelColor: Colors.lightGreen,
                unselectedLabelColor: Color(0xff666666),
                labelStyle: TextStyle(fontSize: 16.0,color: Colors.black38),
                tabs: tabList.map((item) {
                  return Tab(
                    text: item.title,
                  );
                }).toList(),
              ),
            ),
            _buildTabRight()
          ],
        ),
      );

  _buildTabRight() => Container(
        height: 38,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Padding(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.list,
                  color: Colors.lightGreen,
                ),
                Text(
                  "更多",
                  style: TextStyle(color: Colors.lightGreen, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );

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