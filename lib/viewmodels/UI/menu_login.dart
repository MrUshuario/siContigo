import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_menuOpciones.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/database/database.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/responseinciofinactividad.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_padron.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuesta.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/constantes.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewBlancoTexto.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpciones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_imei/device_imei.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpcionesOFFLINE.dart';

import '../../utils/helpersviewAlertProgressCircle.dart';
import '../../utils/helpersviewAlertProgressCircleLOGIN.dart';
import '../../utils/helpersviewLetrasRojas.dart';
import 'menu_deOpcionesLISTADO.dart';


class login extends StatefulWidget {


  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formUsuarioCtrl = TextEditingController();
  TextEditingController formClaveCtrl = TextEditingController();


  bool _isPasswordVisible = true;

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => login());

  @override
  State<StatefulWidget> createState() => _login();
}


class PasswordVisibilityToggle extends StatefulWidget {
  const PasswordVisibilityToggle({
    Key? key,
    required this.isPasswordVisible,
    required this.onToggle,
  }) : super(key: key);
  final bool isPasswordVisible;
  final VoidCallback onToggle;
  @override
  State<PasswordVisibilityToggle> createState() => _PasswordVisibilityToggleState();
}

class _PasswordVisibilityToggleState extends State<PasswordVisibilityToggle> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        widget.onToggle();
      },
    );
  }
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
          backgroundColor: Color.fromRGBO(23, 50, 172, 1),
          //leading: Icon(Icons.menu),
          actions: const [
            /*
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
            ), */
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
          color: Color.fromRGBO(23, 50, 172, 1),
          child: Center(
            child: Text(
              '',
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


  }

  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  void CargaDialog() {
    bool mostrarLOADING = false;
    String texto1 = "Sincronizacion fallida";
    String texto2 = "Vuelva a intentar";
    showDialog(
      barrierDismissible: mostrarLOADING,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {

            _mostrarLoadingStreamController.stream.listen((value) {
              setState(() {
                mostrarLOADING = value;
              });
            });

            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    HelpersViewAlertProgressCircleLOGIN(
                      mostrar: mostrarLOADING,
                      texto1: texto1,
                      texto2: texto2,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
              child: Image.asset( Resources.siContigo,
                width: 250,
                height: 100,),
            )),


        HelpersViewLetrasRojas.formItemsDesign2( "Visita Domiciliaria"),


        HelpersViewBlancoTexto.formItemsDesign(
          "Usuario:", // Empty title (optional)
          Center(
            child: TextFormField(
              controller: widget.formUsuarioCtrl,
              //readOnly: true, // Optional: Set to true if the field is read-only
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Optional: Restrict input to digits
              maxLength: 8,
              decoration: InputDecoration(
                hintText: "Usuario", // Hint text for empty field
                counterText: "", // Hides character counter (optional)
              ),
            ),
          ),
        ),


        Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(255, 45, 55, 207)), // Red border
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Optional padding
            child: Center( // Center the text field content
              child: TextFormField(
                controller: widget.formClaveCtrl,
                obscureText: widget._isPasswordVisible,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: "Ingrese su contraseña",
                  counterText: "",
                  suffixIcon: PasswordVisibilityToggle(
                    isPasswordVisible: widget._isPasswordVisible,
                    onToggle: () {
                      setState(() {
                        widget._isPasswordVisible = !widget._isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
            onTap: () async {
              CargaDialog();

              String usuario = widget.formUsuarioCtrl.text!;
              String contra = widget.formClaveCtrl.text!;

              ReponseInicioFinActividades resp = ReponseInicioFinActividades();
              resp = await apiVersion.post_LoginUsuarios(usuario,contra);
              print(resp.nroDoc);
              if(resp.nroDoc != null){


                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('name', resp.name!);
                await prefs.setString('apPaterno', resp.apPaterno!);
                await prefs.setString('apMaterno', resp.apMaterno!);
                await prefs.setString('nroDoc', resp.nroDoc!);
                await prefs.setString('typeUser', resp.typeUser!);
                if (resp.distrito != null) {
                  await prefs.setString('distrito', resp.distrito!);
                } else {
                  await prefs.setString('distrito', "No registrado");
                }
                 //TALVEZ DEPARTAMENTO

                //GUARDAR DATOS
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) =>  MenudeOpcionesListado()),
                );

              }else {
                //NO ENCONTRO
                _mostrarLoadingStreamController.add(true);
                UsuarioNoEncontrado();
              }

            },
            child: Container(
              margin: const EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color.fromARGB(255, 27, 65, 187),
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: const Text("Ingresar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ))
/*
        ,
        GestureDetector(
            onTap: () async {

              Widget ContactoRefererencia = MenudeOpcionesOffline(Respuesta());
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                //MaterialPageRoute(builder: (context) =>  ContactoRefererencia),
                MaterialPageRoute(builder: (context) =>  MenudeOpcionesListado()),
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
*/

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
