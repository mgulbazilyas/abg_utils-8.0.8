import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';

simpleItem(ProductDataCache item, double width, Function() onClick, Function() onAddToCartClick){
  return InkWell(
    onTap: onClick,
      child: Container(
    width: width,
    height: width*0.2,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: width*0.2,
            height: width*0.2,
            child: showImage(item.image, fit: BoxFit.cover),
        )),
        SizedBox(width: 10,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(getTextByLocale(item.name, locale), style: aTheme.style13W800, maxLines: 2,),

          if (item.discPrice != 0)
            Row(children: [
              Text(getPriceString(item.price), style: aTheme.style13W400U, overflow: TextOverflow.ellipsis),
              SizedBox(width: 5,),
              Expanded(child: Text(getPriceString(item.discPrice), style: aTheme.style13W800, overflow: TextOverflow.ellipsis,)),
            ],)
          else
            Text(getPriceString(item.price), style: aTheme.style13W400,),
        ],)),
        SizedBox(width: 10,),
        InkWell(
          onTap: onAddToCartClick,
          child: UnconstrainedBox(
              child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: aTheme.mainColor,
                    borderRadius: BorderRadius.circular(aTheme.radius),
                  ),
                  child: Image.asset("assets/addtocart.png",
                    fit: BoxFit.contain, color: Colors.black,
                  )
              )),
        ),
      ],
    ),
  ));
}