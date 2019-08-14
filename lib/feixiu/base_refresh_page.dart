import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

class BaseRefreshPage extends StatefulWidget {
  Widget child;
  PageRefreshAndLoadingMoreListener listener;
  RefreshController refreshController;

  BaseRefreshPage(
      {Key key,
      @required this.child,
      @required this.listener,
      @required this.refreshController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BaseRefreshPageState();
  }
}

class BaseRefreshPageState extends State<BaseRefreshPage> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: widget.refreshController,
      onRefresh: () {
        widget.listener.onRefresh();
      },
      onLoading: () {
        widget.listener.onLoading();
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.refreshController.dispose();
    super.dispose();
  }
}

abstract class PageRefreshAndLoadingMoreListener {
  void onRefresh();

  void onLoading();
}
