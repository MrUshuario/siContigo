import 'package:flutter/material.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpciones.dart';

import '../viewmodels/UI/menu_deOpcionesLISTADO.dart';

class HelpersViewAlertProgressCircleLOGIN extends StatelessWidget {

    const HelpersViewAlertProgressCircleLOGIN({super.key,
      required this.mostrar,
      required this.texto1,
      required this.texto2,
    });

    final bool mostrar;
    final String texto1;
    final String texto2;

    final double width = 100.0;
    final double height = 100.0;

    @override
    Widget build(BuildContext context) {

      return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [



              Visibility(
                visible: !mostrar,
                child:Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),

               Container(
                      width: width,
                      height: height,
                      child: const CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                      strokeWidth: 10,
                    ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),

               ],),

              ),

              Visibility(
                visible: mostrar,
              child:Column(
              children: <Widget>[

                Align(
                  alignment: Alignment.topLeft, // Align to top left corner
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, top: 20, right: 20),
                    child: Row(
                      children: [
                        Image.asset(Resources.iconInfo),
                        Expanded(
                          child: Text(
                            texto1,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                    padding: EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text (texto2)
                        ),
                      ],
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // Align row to the end
                  children: [
                    Spacer(), // Push remaining space to the left

                    InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenudeOpcionesListado()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, right: 20, bottom: 20),
                        child: const Text(
                          "Ir al menú",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {

                        Navigator.of(context).pop();

                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, right: 20, bottom: 20),
                        child: const Text(
                          "Cerrar",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                  ],
                ),

              ],),
              ),

        ],);
    }

}