import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/base_refresh_page.dart';
import 'package:flutter_demo/feixiu/state_page.dart';
import 'package:flutter_demo/feixiu/widget/part_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';

class PartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PartPageState();
  }
}

class PartPageState extends State<PartPage>
    with PageRefreshAndLoadingMoreListener,AutomaticKeepAliveClientMixin {
  final StateController _stateController =
  StateController(currentState: PageState.PAGE_LOADING);
  final RefreshController controller = RefreshController(initialRefresh: false);
  Widget sucWidget;
  int itemCount = 20;
  List list;

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatePage(
        sucPage: _buildSucPage(),
        emptyPage: _buildEmpty(),
        errorPage: _buildError(),
        loadingPage: _buildLoading(),
        controller: _stateController,
      ),
    );
  }

  Widget _buildSucPage() {
//    if(sucWidget == null){
      sucWidget = BaseRefreshPage(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return PartItem(part: list[index]);
          },
          itemCount: itemCount,
        ),
        listener: this,
        refreshController: controller,
      );
//    }
    return sucWidget;
  }

  Widget _buildEmpty() =>
      Container(
        child: Center(
          child: Text("空"),
        ),
      );

  Widget _buildError() =>
      Container(
        child: Center(
          child: Text("error"),
        ),
      );

  Widget _buildLoading() =>
      Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  @override
  void onLoading() async {
    print("嘿嘿嘿 onLoading");
    await Future.delayed(Duration(milliseconds: 1000));
    var newData = List.generate(2,(int index){
      return Part(index);
    }).toList();
    list.addAll(newData);
    setState(() {
      itemCount = list.length;
    });
    if (itemCount > 30) {
      controller.loadNoData();
    } else {
      controller.loadComplete();
    }
    Toast.show("onLoading", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onRefresh() async {
    print("嘿嘿嘿 onRefresh");
    await Future.delayed(Duration(milliseconds: 1000));
    Toast.show("onRefresh", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    list = List.generate(20,(int index){
      return Part(index);
    }).toList();
    setState(() {
      itemCount = list.length;
      _stateController.currentState = PageState.PAGE_SUC;
    });
    controller.refreshCompleted(resetFooterState: true);
  }

  @override
  bool get wantKeepAlive => true;
}
