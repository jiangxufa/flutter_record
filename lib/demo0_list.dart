import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


///StatefulWidget和State类。
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  ///在Dart语言中使用下划线前缀标识符，会强制其变成私有的
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  ///保存（收藏）的单词对
  final _saved = Set<WordPair>();

  // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
  // 在偶数行，该函数会为单词对添加一个ListTile row.
  // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
  // 注意，在小屏幕上，分割线看起来可能比较吃力。
  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      // 在每一列之前，添加一个1像素高的分隔线widget
      if (index.isOdd) return Divider();
      // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
      // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
      final i = index ~/ 2;
      // 如果是建议列表中最后一个单词对
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表演示"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
          IconButton(icon: Icon(Icons.hotel), onPressed: _pushOther),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);
    return ListTile(
      title: Text(
        suggestion.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      //点击事件
      onTap: () {
        //setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(suggestion);
          } else {
            _saved.add(suggestion);
          }
        });
      },
    );
  }

  ///跳转收藏页列表
  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final tiles = _saved.map((pair) {
        return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ));
      });
      final divided =
      ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text("收藏详情"),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  ///跳转收藏页列表
  void _pushOther() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("收藏详情"),
        ),
        body: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image(
                    image: NetworkImage(
                        "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4")),
              )
            ],
          ),
        ),
      );
    }));
  }

}