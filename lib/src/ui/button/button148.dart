import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';

button148(String text, String icon, Function _callback,
    {Color? borderColor, Color color = Colors.transparent, double? radius, bool enable = true,
    TextStyle? style, double? width}
){
  return Stack(
    children: <Widget>[
      Container(
        width: width,
          padding: EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: (enable) ? borderColor ?? aTheme.mainColor : Colors.grey.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(radius ?? aTheme.radius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UnconstrainedBox(
                  child: Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(icon,
                          fit: BoxFit.contain
                      )
                  )),
              SizedBox(width: 10,),
              Expanded(child: Text(text, style: style ?? TextStyle(fontSize: 16, fontWeight: FontWeight.w800,
                  color: (enable) ? borderColor : Colors.grey.withOpacity(0.5)
              ), textAlign: TextAlign.center,))
            ],
          )
      ),

      if (enable)
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius ?? aTheme.radius) ),
              child: InkWell(
                splashColor: borderColor == null ? aTheme.mainColor : borderColor.withOpacity(0.2),
                onTap: (){
                  _callback();
                }, // needed
              )),
        )
    ],
  );
}
