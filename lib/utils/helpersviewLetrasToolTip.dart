import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class HelpersViewLetrasToolTip extends StatelessWidget {


  final String message;
  final SuperTooltipController controller;


  const HelpersViewLetrasToolTip({
    super.key,
    required this.message,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.showTooltip();
      },
      child: SuperTooltip(
        showBarrier: true,
        controller: controller,
        content:  formItemsDesignBLUE(message),
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }



  static Widget formItemsDesignBLUE(String text) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child:  Text(
              text,
              textAlign: TextAlign.left,
              style:  TextStyle(
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






