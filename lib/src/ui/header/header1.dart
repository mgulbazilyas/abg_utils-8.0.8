import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';

class Header1 extends StatefulWidget {
  final String text;
  final String address;
  final String time;
  //
  final String button1;
  final String button2;
  final String button3;
  final Function() getActive;
  final Function(String id) onClick;

  const Header1({Key? key, required this.text, required this.address, required this.time,
    required this.button1, required this.button2, required this.button3, required this.getActive,
    required this.onClick}) : super(key: key);

  @override
  _Header1State createState() => _Header1State();
}

class _Header1State extends State<Header1> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            width: windowWidth,
            height: 100+MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              color: aTheme.mainColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Expanded(child: Text(widget.text, style: aTheme.style16W800,),),
                Image.asset("assets/logo.png", height: 30,),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80+MediaQuery.of(context).padding.top, left: 20, right: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.withAlpha(90)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: button2(widget.button1,
                        widget.getActive() == 1 ? aTheme.mainColor : Colors.transparent, (){
                          widget.onClick("1");
                        }, style: aTheme.style14W800)),
                    SizedBox(width: 5,),
                    Expanded(child: button2(widget.button2,
                        widget.getActive() == 2 ? aTheme.mainColor : Colors.transparent, (){
                          widget.onClick("2");
                        }, style: aTheme.style14W800)),
                    SizedBox(width: 5,),
                    Expanded(child: button2(widget.button3,
                        widget.getActive() == 3 ? aTheme.mainColor : Colors.transparent, (){
                          widget.onClick("3");
                        }, style: aTheme.style14W800)),
                  ],
                ),
                SizedBox(height: 5,),
                Divider(),
                SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    widget.onClick("address");
                  },
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.pink.withAlpha(150), size: 15,),
                    SizedBox(width: 10,),
                    Expanded(child: Text(widget.address, style: aTheme.style12W800,)),
                    Icon(Icons.timer, color: Colors.deepPurple, size: 15,),
                    SizedBox(width: 5,),
                    Text(widget.time, style: aTheme.style12W800,),
                    SizedBox(width: 5,),
                    Icon(Icons.keyboard_arrow_down_rounded, color: Colors.deepPurple, size: 25,),
                  ],
                )),
              ],
            ),

          )
        ],
      ),
    );
  }
}