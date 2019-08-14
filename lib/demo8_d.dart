import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/state_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'feixiu/base_refresh_page.dart';

class HahaPage extends StatefulWidget {
  final RefreshController controller = RefreshController(initialRefresh: true);
  final StateController _stateController = StateController(currentState: PageState.PAGE_SUC);
  int itemCount = 20;

  @override
  State<StatefulWidget> createState() {
    return HahaPageState();
  }
}

class HahaPageState extends State<HahaPage>
    with PageRefreshAndLoadingMoreListener {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "浮动应用栏",
      home: Scaffold(
          body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {});
            },
            child: Text("切换布局"),
          ),
          StatePage(
//              key: statePageKey,
            sucPage: _buildSucPage(),
            emptyPage: _buildEmpty(),
            errorPage: _buildError(),
            loadingPage: _buildLoading(),
            controller: widget._stateController,
          ),
        ],
      )),
    );
  }

  Widget _buildSucPage() => BaseRefreshPage(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("啊是大"),
            );
          },
          itemCount: widget.itemCount,
        ),
        listener: this,
        refreshController: widget.controller,
      );

  Widget _buildEmpty() => Container(
        child: Center(
          child: Text("空"),
        ),
      );

  Widget _buildError() => Container(
        child: Center(
          child: Text("error"),
        ),
      );

  Widget _buildLoading() => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  @override
  void onLoading() async {
    print("嘿嘿嘿 onLoading");
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      widget.itemCount++;
    });
//    widget.controller.loadComplete();
    widget.controller.loadNoData();
  }

  @override
  void onRefresh() async {
    print("嘿嘿嘿 onRefresh");
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      widget.itemCount = 20;
    });
    widget.controller.refreshCompleted(resetFooterState: true);
  }
}
