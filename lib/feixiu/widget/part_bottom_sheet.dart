import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class SpuBottomSheetLayout extends Container {
  List<String> datas = List.generate(20, (index) {
    return "第$index个";
  });

  @override
  Widget get child => ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: new Container(
              color: Colors.lightGreen,
              height: 40.0,
              padding: new EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: new Text(
                'Header #$index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            content: Container(
              padding: EdgeInsets.all(8),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: datas.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,childAspectRatio: 3/1),
                  itemBuilder: (BuildContext context, int index) {
                    return getItemContainer(datas[index]);
                  }),
            ),
          );
        },
        shrinkWrap: true,
      );

  Widget getItemContainer(String item) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.lightGreen)),
      child: Text(
        item,
        style: TextStyle(color: Colors.lightGreen, fontSize: 20),
      ),
    );
  }
}

class GridHeader extends StatefulWidget {
  @override
  _GridHeaderState createState() => _GridHeaderState();
}

class _GridHeaderState extends State<GridHeader> {
  List<String> listHeader = [
    'HEADER1',
    'HEADER2',
    'HEADER3',
    'HEADER4',
    'HEADER5',
    'HEADER6',
    'HEADER7',
    'HEADER8',
    'HEADER9',
    'HEADER10',
  ];
  List<String> listTitle = [
    'title1',
    'title2',
    'title3',
    'title4',
  ];

  @override
  Widget build(BuildContext context) {
    return gridHeader();
  }

  Widget gridHeader() {
    return new ListView.builder(
      itemCount: listHeader.length,
      itemBuilder: (context, index) {
        return new StickyHeader(
          header: new Container(
            height: 38.0,
            color: Colors.white,
            padding: new EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              listHeader[index],
              style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listTitle.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (contxt, indx) {
                return Card(
                  margin: EdgeInsets.all(4.0),
                  color: Colors.purpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 6.0, bottom: 2.0),
                    child: Center(
                        child: Text(
                      listTitle[indx],
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                  ),
                );
              },
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }
}
