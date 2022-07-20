import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomAbout{
  Widget aboutPage(IconData icon, String title, String subTitle, Function() tap){
    return Column(
      children: [
        Divider(
          color: CustomColor.black.withOpacity(0.5),
          height: 1,
          thickness: 1,
        ),
        const SizedBox(height: 10,),
        GestureDetector(
          onTap: tap,
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(
                      color: CustomColor.black, fontSize: 17
                  ),),
                  const SizedBox(height: 5,),
                  Text(subTitle, style: TextStyle(
                      color: CustomColor.black.withOpacity(0.5), fontSize: 17
                  ),),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}