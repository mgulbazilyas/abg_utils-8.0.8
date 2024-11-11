import 'package:flutter/material.dart';

card35(List<int> rows, List<String> desc, TextStyle style,
    Color colorSelect, Color colorUnSelect, double radius, bool shadow, Color bkgColor)
{
  List<Widget> list = [];
  list.add(Expanded(child: Container()));
  var index = 0;
  for (var item in rows){
    List<Widget> listColumn = [];
    for (var i = 10; i > 0; i--) {
      double _radius = 0;
      if (i == 1)
        _radius = 10;
      double _radius2 = 0;
      if (i == 10 || item == i)
        _radius2 = 10;
      listColumn.add(Expanded(child: Container(
          decoration: BoxDecoration(
            color: (item >= i) ? colorSelect : colorUnSelect,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_radius), bottomRight: Radius.circular(_radius),
                topLeft: Radius.circular(_radius2), topRight: Radius.circular(_radius2)),
          )),
      ));
    }
    if (desc.length > index)
      listColumn.add(Text(desc[index], style: style, maxLines: 1,));
    list.add(Expanded(child: Column(children: listColumn,)));
    list.add(Expanded(child: Container()));
    index++;
  }

  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    decoration: BoxDecoration(
      color: bkgColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: (shadow) ? [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 5,
          offset: Offset(3, 3),
        ),
      ] : null,
    ),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list
    ),
  );
}

