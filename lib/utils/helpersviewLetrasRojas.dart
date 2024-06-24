import 'package:flutter/material.dart';

class HelpersViewLetrasRojas {

static Widget formItemsDesign(String text) {
  return SingleChildScrollView( // Wrap with SingleChildScrollView
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the Row
      children: [
        const SizedBox(width: 0.0), // Maintain left padding
        Flexible( // Wrap container in Flexible
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 200.0, // Set minimum width
              maxWidth: double.infinity, // Allow container to grow horizontally
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center, // Maintain left alignment
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 0.0), // Maintain right padding (optional)
      ],
    ),
  );
}



static Widget formItemsDesign2(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center the Row
    children: [
      // No SizedBox needed for left padding here (optional)

      Flexible( // Wrap container in Flexible with flex: 2
        flex: 13, // Set the flex factor to 2
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 200.0, // Set minimum width
            maxWidth: double.infinity, // Allow container to grow horizontally
          ),
          decoration: const BoxDecoration(
            //color: Colors.red, // Add a background color if needed
          ),
          child: Text(
            text,
            textAlign: TextAlign.center, // Maintain center alignment
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),

      const Expanded( // Add an Expanded widget for remaining space
        child: SizedBox(), // Empty SizedBox to consume remaining space
      ),
    ],
  );
}


static Widget formItemsPREGUNTA(int index, String ipregunta, String itexto, String idescripcion,  context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.010,
      ),

      /*
            Text(
        "${index + 1}) ${ipregunta ?? ""}:  ${itexto ?? ""}", // Example,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
       */

      Text(
        "${idescripcion ?? ""}", // Example,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.blue,
        ),
      ),


      Text(
        "${index + 1}) ${ipregunta ?? ""}", // Example,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      Text(
        "${itexto ?? ""}", // Example,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),


      SizedBox(
        height: MediaQuery.of(context).size.height * 0.010,
      ),

    ],
  );
}



}