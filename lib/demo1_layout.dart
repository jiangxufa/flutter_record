import 'package:flutter/material.dart';

class Demo1Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("布局"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ListView(
      children: <Widget>[
        _buildImageTitle(),
        _buildSecondContent(),
        _buildThreeContent(),
        _buildLastContent()
      ],
    );
  }

  _buildImageTitle() {
    return Image.asset(
      "images/lake.jpg",
      height: 240.0,
      fit: BoxFit.cover,
    );
  }

  _buildSecondContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("这是第一行"),
              Text("这是第二行"),
            ],
          )),
          FavoriteWidget()
        ],
      ),
    );
  }

  _buildThreeContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(64, 0, 64, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[Icon(Icons.phone), Text("CALL")],
          ),
          Column(
            children: <Widget>[Icon(Icons.navigation), Text("ROUTE")],
          ),
          Column(
            children: <Widget>[Icon(Icons.share), Text("SHARE")],
          )
        ],
      ),
    );
  }

  _buildLastContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 16, 32, 160),
      child: Text(
          "首先，构建标题部分左边栏。将Column（列）放入Expanded中会拉伸该列以使用该行中的所有剩余空闲空间。 设置crossAxisAlignment属性值为CrossAxisAlignment.start，这会将该列中的子项左对齐。"
          "将第一行文本放入Container中，然后底部添加8像素填充。列中的第二个子项（也是文本）显示为灰色。"
          "标题行中的最后两项是一个红色的星形图标和文字“41”。将整行放在容器中，并沿着每个边缘填充32像素"
          "这是实现标题行的代码。"),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoriteState();
  }
}

class FavoriteState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: IconButton(
              icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
              onPressed: _toggleFavorite),
        ),
        SizedBox(
          width: 18,
          child: Text("$_favoriteCount"),
        )
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}
