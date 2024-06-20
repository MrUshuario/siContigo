import 'package:flutter/material.dart';

class HelpersViewLetrasSubs {

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
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              //color: Colors.white,
            ),
          ),
        ),
        ),

      ],
    );
  }

  static Widget formItemsDesignBLUE(String text) {
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
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),

      ],
    );
  }

}

