import 'package:flutter/material.dart';

class StatePage extends StatelessWidget {
  final Widget sucPage;
  final Widget emptyPage;
  final Widget loadingPage;
  final Widget errorPage;
  final StateController controller;

  StatePage(
      {Key key,
      @required this.sucPage,
      this.emptyPage,
      this.loadingPage,
      this.errorPage,
      @required this.controller})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  _buildSucPage() => sucPage;

  _buildEmptyPage() => emptyPage;

  _buildLoadingPage() =>loadingPage;

  _buildErrorPage() => errorPage;

   _buildPage() {
    switch (controller.currentState) {
      case PageState.PAGE_SUC:
        return _buildSucPage();
      case PageState.PAGE_EMPTY:
        return _buildEmptyPage();
      case PageState.PAGE_LOADING:
        return _buildLoadingPage();
      case PageState.PAGE_ERROR:
        return _buildErrorPage();
    }
  }
}


class StateController {
  PageState currentState;

  StateController({this.currentState: PageState.PAGE_LOADING});
}

enum PageState { PAGE_SUC, PAGE_EMPTY, PAGE_LOADING, PAGE_ERROR }
