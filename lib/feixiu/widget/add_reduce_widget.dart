import 'package:flutter/material.dart';
import 'package:flutter_demo/feixiu/widget/part_item.dart';

class AddReduceLayout extends StatelessWidget {
  final Part _part;
  final OnAddReduceClickListener _listener;

  AddReduceLayout(this._part, this._listener);

  @override
  Widget build(BuildContext context) {
    print(_part.hashCode);
    return _part.num == 0 ? _buildOnlyAddLayout() : _buildAddReduceLayout();
  }

  Widget _buildAddReduceLayout() {
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              padding: EdgeInsetsDirectional.zero,
              icon: Image.asset(
                "images/btn_reduce_fault.png",
                fit: BoxFit.cover,
              ),
              onPressed: () {
                _listener.onReduceClick();
              }),
          GestureDetector(
            onTap: null,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      _part.num.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ),
          ),
          IconButton(
              padding: EdgeInsetsDirectional.zero,
              icon: Image.asset(
                "images/btn_increase_default.png",
                width: 28,
                height: 28,
                fit: BoxFit.cover,
              ),
              onPressed: () {
                _listener.onAddClick();
              }),
        ],
      ),
    );
  }

  Widget _buildOnlyAddLayout() {
    return Container(
      width: 100,
      alignment: Alignment.centerRight,
      child: IconButton(
          icon: Image.asset(
            "images/btn_increase_default.png",
            width: 44,
            height: 44,
          ),
          onPressed: () {
            _listener.onAddClick();
          }),
    );
  }
}
