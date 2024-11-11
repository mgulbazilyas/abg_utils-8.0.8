import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../abg_utils.dart';

/*
offerWidget(currentOffer.color, strings.get(510), /// "Special offer"
          theme.style12W600White, currentOffer.image,
          disc, theme.style14W800,
          400, 200,
 */

Widget offerWidget(Color color, String text, TextStyle style, String image,
    String text2, TextStyle style2, double width, double height,
    String text3, TextStyle style3,
    String text4, TextStyle style4){
  return Row(
      children: [
        SizedBox(
            height: height,
            width: width,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: ClipPath(
                        clipper: ClipPathClass2(10),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: color,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(text, style: style, maxLines: 2,),
                                FittedBox(child: showImage(image, width: 10000, height: 10000))
                              ]
                          ),
                        ))),
                CustomPaint(
                    painter: ClipPathClass4Painter(color, 4),
                    child: Container(width: 2,)
                ),
                Expanded(
                    flex: 2,
                    child: CustomPaint(
                      painter: ClipPathClass3Painter(10, Colors.grey, 2),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                text2,
                                style: style2,
                                maxLines: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                    child: Text(text3, style: style3,),
                                  )
                                ],
                              ),
                              Text(text4, style: style4, maxLines: 1,),
                            ]
                        ),
                      ),
                    )),

              ],
            ) ) ]
  );
}
