import 'package:flutter/material.dart';

///StatefulWidget和State类。
class StateDemoLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '关于state的管理Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('关于state的管理Demo'),
        ),
        body: ListView(
          children: <Widget>[TapBoxA(), ParentWidget(), ParentWidgetC()],
        ),
      ),
    );
  }
}

class TapBoxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TapBixState();
  }
}

/// ***************************************widget管理自己的状态****************************************************/
class TapBixState extends State<TapBoxA> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: <Widget>[
          Text("widget管理自己的状态"),
          GestureDetector(
            onTap: _handleTap,
            child: Container(
              child: Center(
                child: Text(
                  _active ? "Active" : "Inactive",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
            ),
          )
        ],
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }
}

/// ***************************************widget管理自己的状态****************************************************/

/// ***************************************父widget管理widget的state****************************************************/
class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return TapBoxB(
      active: _active,
      onChange: _handleTapBoxChanged,
    );
  }

  //函数传递？？？
  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }
}

class TapBoxB extends StatelessWidget {
  final bool active;

  //回调
  final ValueChanged<bool> onChange;

  TapBoxB({Key key, this.active = false, @required this.onChange})
      : super(key: key);

  void _handleTap() {
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: <Widget>[
          Text("父widget管理widget的state,子View无状态，父View有状态，直接回调到父View"),
          GestureDetector(
            onTap: _handleTap,
            child: Container(
              child: Center(
                child: Text(
                  active ? "Active" : "Inactive",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: active ? Colors.lightGreen[700] : Colors.grey[600]),
            ),
          )
        ],
      ),
    );
  }
}

/// ***************************************父widget管理widget的state****************************************************/

/// ***************************************混合管理****************************************************/
class ParentWidgetC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgeCtState();
  }
}

class _ParentWidgeCtState extends State<ParentWidgetC> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return TapBoxC(
      active: _active,
      onChange: _handleTapBoxChanged,
    );
  }

  //函数传递？？？
  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }
}

class TapBoxC extends StatefulWidget {
  final bool active;

  //回调
  final ValueChanged<bool> onChange;

  TapBoxC({Key key, this.active = false, @required this.onChange})
      : super(key: key);

  void _handleTap() {
    onChange(!active);
  }

  @override
  State<StatefulWidget> createState() {
    return TapBoxCState();
  }
}

class TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChange(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: <Widget>[
          Text("混合管理,子View和父View都时有状态的"),
          GestureDetector(
            onTap: _handleTap,
            onTapDown: _handleTapDown,
            // Handle the tap events in the order that
            onTapUp: _handleTapUp,
            // they occur: down, up, tap, cancel
            onTapCancel: _handleTapCancel,
            child: Container(
              child: Center(
                child: Text(
                  widget.active ? "Active" : "Inactive",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color:
                    widget.active ? Colors.lightGreen[700] : Colors.grey[600],
                border: _highlight
                    ? Border.all(color: Colors.teal[700], width: 10)
                    : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// ***************************************混合管理****************************************************/
