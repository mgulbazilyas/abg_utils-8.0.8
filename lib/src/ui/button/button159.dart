import 'package:flutter/material.dart';

import '../../../abg_utils.dart';

button159(String text, List<Color> gradient, IconData icon, Function _callback,
    {bool enable = true, double? radius, TextStyle? style, double iconSize = 20,
      String? text2, TextStyle? style2, Color borderColor = Colors.transparent,
      Color iconColor = Colors.white}){
  return Stack(
    children: <Widget>[

      Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(radius ?? aTheme.radius)),
              gradient: (enable) ?  LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: gradient,
              ) : LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.grey.withOpacity(0.5), Colors.grey.withOpacity(0.5)],
              )
          ),
          child: Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: style ?? aTheme.style16W800White, textAlign: TextAlign.start,),
                  SizedBox(height: 10,),
                  if (text2 != null)
                    Text(text2, style: style2 ?? aTheme.style16W800White, textAlign: TextAlign.start,)
                ],
              )),
              Icon(icon, color: iconColor, size: iconSize, ),
            ],
          )
      ),
      if (enable)
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius ?? aTheme.radius)),
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.2),
                onTap: (){
                  _callback();
                }, // needed
              )),
        )

    ],
  );
}
