import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';

button207(String text, Function() callback, {
  String? text2,
  IconData? iconLeft, Color? iconLeftColor,
  IconData? iconRight, Color? iconRightColor,
}){
  return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: InkWell(
          onTap: callback,
          child: Row(
            children: [
              if (iconLeft != null)
                Icon(iconLeft, color: iconLeftColor ?? aTheme.secondColor, size: 20,),
              SizedBox(width: 10,),
              Expanded(child: Text(text, style: aTheme.style12W800,)),
              if (text2 != null)
                Text(text2, style: aTheme.style12W800,),
              SizedBox(width: 5,),
              if (iconRight != null)
                Icon(iconRight, color: iconRightColor ?? aTheme.secondColor, size: 15,),
            ],
          ))
  );
}
