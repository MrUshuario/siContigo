import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sicontigo/infraestructure/dao/apis/apiprovider_menuOpciones.dart';
import 'package:sicontigo/infraestructure/dao/database/database.dart';
import 'package:sicontigo/model/responseinciofinactividad.dart';
import 'package:sicontigo/model/t_respuesta.dart';
import 'package:sicontigo/utils/constantes.dart';
import 'package:sicontigo/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:sicontigo/utils/helpersviewBlancoTexto.dart';
import 'package:sicontigo/utils/resources.dart';
import 'package:sicontigo/viewmodels/UI/menu_deOpciones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
import 'package:sicontigo/viewmodels/UI/menu_deOpcionesOFFLINE.dart';


class login extends StatefulWidget {


  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formUsuarioCtrl = TextEditingController();
  TextEditingController formClaveCtrl = TextEditingController();

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => login());

  @override
  State<StatefulWidget> createState() => _login();
}

class _login extends State<login> {
  var _androidId = 'Unknown';

  //late int PREFversionInstancia;
  late String PREFversionAplicacionVigente;
  late var PREF_androidId;

  late final _appDatabase;
  //FormDataModelDaoVERSION get formDataModelDao => _appDatabase.formDataModelDaoVersion;
  late String versionPrintAplicacion = "(Falta sincronizar)";

  //IMEI
  String _platformVersion = 'Unknown';
  String? deviceImei;
  String? type;
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  bool isloading = false;
  final _deviceImeiPlugin = DeviceImei();
  apiprovider_menuOpciones apiVersion = apiprovider_menuOpciones();


  String? ConcatDepart;
  String? UTCONCAT = "DESCONOCIDO";


  @override
  void initState() {
    super.initState();
    initializeDatabase();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //SACA LA BARRA DEBUG
      home: Scaffold(
        appBar: AppBar(
          title: const Text(Constants.tituloMenuLogin, style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFD60000),
          //leading: Icon(Icons.menu),
          actions: [
            IconButton(
              icon: Image.asset(Resources.iconInfo),
              color: Colors.white,
              onPressed: () async {

              },
            ),
            IconButton(
              icon: Image.asset(Resources.iconDownload),
              color: Colors.white,
              onPressed: () async {

              },
            ),
            IconButton(
              icon: Image.asset(Resources.iconCandado),
              color: Colors.white,
              onPressed: () {

                },
            ),
          ],
        ),
        //drawer: const MenuLateral(),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 420,
              margin: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Form(
                key: widget.keyForm,
                child: formUI(),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 50, // Altura de la barra
          color: Color(0xFFD60000),
          child: Center(
            child: Text(
              'U.T. ${UTCONCAT}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void UsuarioNoEncontrado() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeTitulo.formItemsDesign(
                          "No se ha encontrado el usuario"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () async {

                                Navigator.pop(context);

                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Entiendo",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )));
        });
  }


  Future<void> initializeDatabase() async {
    _appDatabase = await GetIt.I.get<AppDatabase>();
  }

  Future<void> initPlatformState() async {

    String platformVersion;
    try {
      platformVersion = await _deviceImeiPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      UTCONCAT = "DESCONOCIDO";
    });

    //AlertCargando("Esta aplicación recoge datos de ubicación para habilitar las funciones de captura de Coordenadas de la Actividad que sincronizara. Esta captura se actualizara en cuanto Presione el boton del Sátelite en la esquina superior");

  }




  //REVISAR SI HAY INTERNET
  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Hay conexión a Internet
      }
    } on SocketException catch (_) {
      return false; // No hay conexión a Internet
    }
    return false; // No hay conexión a Internet
  }

  Widget formUI() {
    return Column(
      children: <Widget>[

        Align(
            alignment: Alignment.topCenter,
            child: Container(
              /*
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ), */
              margin: EdgeInsets.only(top: 10),
              child: Image.asset( Resources.loginlogo,
                width: 250,
                height: 60,),
            )),

        Align(
            alignment: Alignment.topCenter,
            child: Container(
              //margin: EdgeInsets.only(bottom: 20),
              child: Image.asset( Resources.tayta,
                width: 250,
                height: 100,),
            )),

        HelpersViewBlancoTexto.formItemsDesign(
          "N#Documento",
          TextFormField(
            controller: widget.formUsuarioCtrl,
            //readOnly: true,
            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 20,
          ),
        ),

        HelpersViewBlancoTexto.formItemsDesign(
          "Clave",
          TextFormField(
            controller: widget.formClaveCtrl,
            //readOnly: true,
            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 20,
          ),
        ),

        GestureDetector(
            onTap: () async {

              String usuario = widget.formUsuarioCtrl.text!;
              String contra = widget.formClaveCtrl.text!;

              ReponseInicioFinActividades resp = ReponseInicioFinActividades();
              resp = await apiVersion.post_LoginUsuarios(usuario,contra);
              print(resp.nroDoc);
              if(resp.nroDoc != null){


                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('name', resp.name!);
                await prefs.setString('apPaterno', resp.name!);
                await prefs.setString('apMaterno', resp.name!);
                await prefs.setString('nroDoc', resp.nroDoc!);
                await prefs.setString('typeUser', resp.typeUser!);

                Widget ContactoRefererencia = MenudeOpcionesOffline(Respuesta());
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                  MaterialPageRoute(builder: (context) =>  ContactoRefererencia),
                );

              }else {
                //NO ENCONTRO
                UsuarioNoEncontrado();
              }

            },
            child: Container(
              margin: const EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color(0xFFD60000),
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: const Text("Ingresar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            )),


        GestureDetector(
            onTap: () async {

              Widget ContactoRefererencia = MenudeOpcionesOffline(Respuesta());
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                MaterialPageRoute(builder: (context) =>  ContactoRefererencia),
              );

            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color(0xFFD60000),
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: const Text("Ingreso directo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ))


      ],
    );
  }


  displayDialog(String? title, String? msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(msg!),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

