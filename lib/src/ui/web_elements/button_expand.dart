import 'package:flutter/material.dart';

import '../../../abg_utils.dart';

buttonExpand(String text, bool _expandDescription, Function() onTap, {Color? color, double? radius,
  TextStyle? style}){
  return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? Colors.green.withAlpha(100),
          borderRadius: BorderRadius.circular(radius ?? aTheme.radius),
        ),
        child: Row(
          children: [
            Expanded(child: Text(text, style: style ?? aTheme.style12W600White,)),
            RotatedBox(
              quarterTurns: _expandDescription ? 1 : 3,
              child:Icon(Icons.arrow_back_ios_outlined, color: Colors.white,),
            )
          ],
        ),
      ));
}

