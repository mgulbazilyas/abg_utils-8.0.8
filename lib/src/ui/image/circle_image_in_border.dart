
import 'package:flutter/material.dart';

import '../../../abg_utils.dart';

circleImageInBorder(Color colorBorder, String image, String imageAsset, double size){
  return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: UnconstrainedBox(child: ClipRRect(
            borderRadius: BorderRadius.circular(size),
            child: Container(
                decoration: BoxDecoration(
                  color: aTheme.darkMode ? Colors.black : Colors.white,
                  shape: BoxShape.circle,
                ),
                width: size,
                height: size,
                child: image.isNotEmpty ?
                showImage(image, fit: BoxFit.cover)
                    : Image.asset(imageAsset, fit: BoxFit.cover)),
          )))
  );
}

