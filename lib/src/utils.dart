import 'package:archive/archive.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import '../abg_utils.dart';

bool disableDPrint = false;

dprint(String str){
  if (disableDPrint)
    return;
  if (!kReleaseMode || kIsWeb) print(str);
}

messageOk(BuildContext context, String _text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: aTheme.mainColor,
      duration: Duration(seconds: 5),
      action:  SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      content: Text(_text,
        style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)));
}

messageError(BuildContext context, String _text){
  dprint("messageError $_text");
  addPoint("error", error: _text);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
      action:  SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      content: Text(_text,
        style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)));
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

String generateCode6(){
  var i1 = Random().nextInt(9);
  var i2 = Random().nextInt(9);
  var i3 = Random().nextInt(9);
  var i4 = Random().nextInt(9);
  var i5 = Random().nextInt(9);
  var i6 = Random().nextInt(9);
  return "$i1$i2$i3$i4$i5$i6";
}

Color getColor(String? boardColor){
  if (boardColor == null) {
    return Colors.red;
  }
  var t = int.tryParse(boardColor);
  if (t != null) {
    return Color(t);
  }
  return Colors.red;
}

Color toColor(String? boardColor){
  if (boardColor == null) {
    return Colors.red;
  }
  var t = int.tryParse(boardColor);
  if (t != null) {
    return Color(t);
  }
  return Colors.red;
}

int toInt(String str){
  int ret = 0;
  try {
    ret = int.parse(str);
  }catch(_){}
  return ret;
}

double toDouble(String str){
  double ret = 0;
  try {
    ret = double.parse(str);
  }catch(_){}
  return ret;
}

bool validateEmail(String value) {
  var pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

String checkPhoneNumber(String _phoneText){
  String s = "";
  for (int i = 0; i < _phoneText.length; i++) {
    int c = _phoneText.codeUnitAt(i);
    if ((c == "1".codeUnitAt(0)) || (c == "2".codeUnitAt(0)) || (c == "3".codeUnitAt(0)) ||
        (c == "4".codeUnitAt(0)) || (c == "5".codeUnitAt(0)) || (c == "6".codeUnitAt(0)) ||
        (c == "7".codeUnitAt(0)) || (c == "8".codeUnitAt(0)) || (c == "9".codeUnitAt(0)) ||
        (c == "0".codeUnitAt(0)) || (c == "+".codeUnitAt(0))) {
      String h = String.fromCharCode(c);
      s = "$s$h";
    }
  }
  return s;
}

textFieldToEnd(TextEditingController _controllerName){
  _controllerName.selection = TextSelection.fromPosition(
    TextPosition(offset: _controllerName.text.length),
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}

String compress(String _data){
  List<int> stringBytes = utf8.encode(_data);
  List<int>? gzipBytes = GZipEncoder().encode(stringBytes);
  String compressedString = base64.encode(gzipBytes!);
  // print("compressed string: $compressedString");
  // print("compressed length: ${compressedString.length}");
  return compressedString;
}

String deCompress(String compressedString){
  final decodeBase64Json = base64.decode(compressedString);
  final decodegZipJson = GZipDecoder().decodeBytes(decodeBase64Json);
  final originalJson = utf8.decode(decodegZipJson);
  // print("originalJson: $originalJson");
  return originalJson;
}

callMobile(String phone) async {
  var uri = "tel:${checkPhoneNumber(phone)}";
  if (await canLaunch(uri))
    await launch(uri);
}

openUrl(String uri) async {
  if (await canLaunch(uri))
    await launch(uri);
}

/*
  zip

  использование

  for (var pair in zip([_serverGroup, _cartGroup])){
    var s = pair[0]; // _serverGroup
    var c = pair[1]; // _cartGroup
    if (c.price == s.price && c.discPrice == s.discPrice)
      s.selected = true;
    else
      _notEqual = true;
  }

 */
Iterable<List<T>> zip<T>(Iterable<Iterable<T>> iterables) sync* {
  if (iterables.isEmpty) return;
  final iterators = iterables.map((e) => e.iterator).toList(growable: false);
  while (iterators.every((e) => e.moveNext())) {
    yield iterators.map((e) => e.current).toList(growable: false);
  }
}

Widget horizontalScroll(Widget _child, ScrollController? controller) {
  return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child:
      Scrollbar(
          isAlwaysShown: true,
          controller: controller,
          child: SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: _child)
          ))
  );
}


