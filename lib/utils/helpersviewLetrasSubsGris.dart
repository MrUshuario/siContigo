import 'package:flutter/material.dart';

class HelpersViewLetrasSubsGris {

  static Widget formItemsDesign(String text) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [

        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text(
              text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
                //color: Colors.white,
              ),
            ),
          ),
        ),


      ],
    );
  }
}