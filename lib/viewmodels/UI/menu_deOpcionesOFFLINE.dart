import 'dart:async';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sicontigo/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:sicontigo/infraestructure/dao/database/database.dart';
import 'package:sicontigo/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:sicontigo/infraestructure/dao/formdatamodeldao_respuesta.dart';
import 'package:sicontigo/model/t_formulario.dart';
import 'package:sicontigo/model/t_respuesta.dart';
import 'package:sicontigo/utils/constantes.dart';
import 'package:sicontigo/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:sicontigo/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sicontigo/viewmodels/UI/menu_login.dart';
import 'package:sicontigo/viewmodels/UI/viewmodels/form_viewsmodel_formulario.dart';
import '../../model/t_insertarEncuestaRSPTA.dart';
import '../../utils/helpersviewAlertFaltaMSG.dart';
import '../../utils/helpersviewAlertProgressCircle.dart';
import '../../utils/helpersviewBlancoIcon.dart';
import '../../utils/helpersviewBlancoSelect.dart';
import '../../utils/helpersviewLetrasRojas.dart';
import '../../utils/helpersviewLetrasSubs.dart';
import '../../utils/helperviewCabecera.dart';


class MenudeOpcionesOffline extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuesta get formDataModelDao => _appDatabase.formDataModelDaoRespuesta;

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController formGestorSocialCtrl = TextEditingController(); //SELECT 1
  //SIGUIENTE
  TextEditingController formDNICtrl = TextEditingController(); //INPUT 2
  TextEditingController formNombresApeCtrl = TextEditingController(); //INPUT 3
  //SIGUIENTE
  TextEditingController formPadronCtrl = TextEditingController(); //CIRCLE 4
  TextEditingController formTiempoCtrl = TextEditingController(); //CIRCLE 5
    TextEditingController formPensionTiempoCtrl = TextEditingController(); //CHECK 6 CAMBIA
  TextEditingController formNecesidadesCtrl = TextEditingController(); //CIRCLE 7
  TextEditingController formEstablecimientoSaludCtrl = TextEditingController(); //CIRCLE 8
  TextEditingController formSeAtendioCtrl = TextEditingController(); //CIRCLE 9
  TextEditingController formServicioAtencionCtrl = TextEditingController(); //CHECK 10 CAMBIA
  //SIGUIENTE

  final ParamGestor = List.filled(3, "", growable: false);

  List<String> listMotivo = [
    "Seleccionar un gestor social",
    "RITTA JACQUELINE ORREGO HUAMAN",
    "ROBERT SEMION CANAZA VEGA",
    "ELVIS CLAUDIO GARCIA BELLO",
    "ELDER JAIME CASTREJON RIOS",
  ];

  //ENVIAR LA DATA
  apiprovider_formulario apiForm = apiprovider_formulario();
  Respuesta? formData;
  MenudeOpcionesOffline(this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesOffline();
  }

}

//enum EstadoFallecido { Si, No }

class _MenudeOpcionesOffline extends State<MenudeOpcionesOffline> {

  late String PREFname;
  late String PREFapPaterno;
  late String PREFapMaterno;
  late String PREFnroDoc;
  late String PREFtypeUser;
  late String PREFtoken;

  late String GPSlatitude = "";
  late String GPSlongitude = "";
  late String GPSaltitude = "";

  Future<void> conseguirVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      PREFname = prefs.getString('name') ?? "ERROR";
      PREFapPaterno = prefs.getString('apPaterno') ?? "ERROR";
      PREFapMaterno = prefs.getString('apMaterno') ?? "ERROR";
      PREFnroDoc = prefs.getString('nroDoc') ?? "ERROR";
      PREFtypeUser = prefs.getString('typeUser') ?? "ERROR";
      PREFtoken = prefs.getString('token') ?? "ERROR";

      GPSlatitude = prefs.getString('latitude') ?? "";
      GPSlongitude = prefs.getString('longitude') ?? "";
      GPSaltitude = prefs.getString('altitude') ?? "";

      if(GPSlatitude == ""){
        print("NO COORDENADAS");

      } else {
        print("HAY COORDENADAS");
        isSatelliteGreen = true;
      }


    });
  }

  @override
  void initState() {
    conseguirVersion();

    /* BACKUP PERO ME TOMARIA 3 HORAS HACERLO
    if(widget.formData != null) {

      if (widget.formData!.observacion != null && widget.formData!.observacion!.isNotEmpty) {
        setState(() {
          widget.formIngresarObsCtrl!.text = widget.formData!.observacion!;
        });
      }

    } */

    // TODO: implement initState
    super.initState();
  }

  bool isSatelliteGreen=false;

  bool Fase1 = false;
  bool Fase2 = true;
  bool Fase3 = false;
  bool Fase4 = false;

  Future<void> capturarCoordenadas() async{
    HelpersViewCabecera.CoordenadasGPS(context).then((value) async {
      // Luego de recopilar la ubicación y la fecha, actualiza el estado del icono
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isSatelliteGreen = true;
        GPSlatitude = prefs.getString('latitude') ?? "";
        GPSlongitude = prefs.getString('longitude') ?? "";
        GPSaltitude = prefs.getString('altitude') ?? "";
      });
    });
  }

  void PedirPermiso(){

    showDialog(
        context: context,
        builder: (context){
          //AGREGAR ESTO POR SI QUIERO QUE EL DIALOG SE REFRESQUE
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [

                      HelpersViewAlertMensajeTitulo.formItemsDesign("Se recogerá sus coordenadas actuales"),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Align row to the end
                        children: [
                          Spacer(), // Push remaining space to the left

                          InkWell(
                            onTap: () async {

                              await capturarCoordenadas();

                              Navigator.pop(context);
                            },

                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Aceptar",
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
                                "Cancelar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],
                  )
              )
          );

        }
    );

  }


  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  void CargaDialog() {
    bool mostrarLOADING = true;
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
                    HelpersViewAlertProgressCircle(
                      mostrar: mostrarLOADING,
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          Constants.tituloMenudeOpciones,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD60000),
        //leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Image.asset(Resources.flechaazul),
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Image.asset(Resources.iconInfo),
                        SizedBox(width: 4), // Espacio entre el icono y el texto
                        Expanded(
                          child: Text(
                            '¿Seguro que quieres salir?',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20, // Tamaño de fuente deseado
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      ButtonBar(
                        alignment: MainAxisAlignment.start, // Alinea los botones a la izquierda
                        children: [
                          TextButton(
                            onPressed: () {

                              Navigator.pop(context); // Cierra el diálogo
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => login()),
                              );

                            },
                            child: const Text('Sí',
                              style: TextStyle(
                                fontSize: 18, // Tamaño de fuente deseado
                              ),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cierra el diálogo
                            },
                            child: const Text('No',
                              style: TextStyle(
                                fontSize: 18, // Tamaño de fuente deseado
                              ),),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),

          IconButton(
            icon: Image.asset(Resources.guardar),
            color: Colors.white,
            onPressed: () async {


              if ( GPSlongitude != "") {



                if ( (widget.formDNICtrl!.text == "" ||widget.formDNICtrl!.text.isEmpty) ||
                   // (widget.formGestorSocialCtrl.text == "" ||widget.formGestorSocialCtrl!.text.isEmpty) ||
                    (widget.formNombresApeCtrl.text == "" ||widget.formNombresApeCtrl!.text.isEmpty) //||
                    //(widget.formPadronCtrl!.text == "" ||widget.formPadronCtrl!.text.isEmpty) ||
                    //(widget.formTiempoCtrl!.text == "" ||widget.formTiempoCtrl!.text.isEmpty) ||
                    //(widget.formPensionTiempoCtrl!.text == "" ||widget.formPensionTiempoCtrl!.text.isEmpty) ||
                    //(widget.formNecesidadesCtrl!.text == "" ||widget.formNecesidadesCtrl!.text.isEmpty) ||
                    //(widget.formEstablecimientoSaludCtrl!.text == "" ||widget.formEstablecimientoSaludCtrl!.text.isEmpty) ||
                    //(widget.formSeAtendioCtrl!.text == "" ||widget.formSeAtendioCtrl!.text.isEmpty) ||
                    //(widget.formServicioAtencionCtrl!.text == "" ||widget.formServicioAtencionCtrl!.text.isEmpty)

                ) {

                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);

                } else {
                  CargaDialog(); //INICIALIZA DIALOGO

                  String respuestas = "";

                  respuestas = ''
                      //'${widget.formGestorSocialCtrl!.text},'
                      '${widget.formDNICtrl!.text},'
                      '${widget.formNombresApeCtrl!.text},'
                      'Latitud:${GPSlatitude},'
                      'altitud:${GPSaltitude},'
                      'longitud:${GPSlongitude},'
                      'Nombre:${PREFname},'
                      'Appaterno:${PREFapPaterno},'
                      'MatMaterno:${PREFapMaterno},'
                      'DNI:${PREFnroDoc},'
                      'TipoUsuario:${PREFtypeUser},'
                  ;

                  widget.formData?.idformato = 0;
                  widget.formData?.id_usuario = 0;
                  widget.formData?.fecha = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.respuestas = respuestas;

                  insertarEncuestaRSPTA rpta = await widget.apiForm.post_EnviarRspt(widget.formData!, PREFtoken);

                  //await GuardarFormulario();

                  await widget.formDataModelDao.insertFormDataModel(widget.formData!);
                  cleanForm();
                  _mostrarLoadingStreamController.add(true);

                }
              } else {
                HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP", context);
              }

            },
          ),

          IconButton(
            icon: Image.asset(
              isSatelliteGreen ? Resources.sateliteverde : Resources.sateliterojo,
              // Usa la imagen verde si isSatelliteGreen es verdadero, de lo contrario, usa la imagen roja
            ),
            color: Colors.white,
            onPressed: () {
              if(!isSatelliteGreen) {

                PedirPermiso();

              } else {
                HelpersViewCabecera.CoordenadasGPS(context).then((value) async {
                  // Luego de recopilar la ubicación y la fecha, actualiza el estado del icono
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  setState(() {
                    isSatelliteGreen = true;
                    GPSlatitude = prefs.getString('latitude') ?? "";
                    GPSlongitude = prefs.getString('longitude') ?? "";
                    GPSaltitude = prefs.getString('altitude') ?? "";
                  });
                });
              }
            },
          ),

        ],
      ),
      body: Center (
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 440.0, // Set your minimum width here
              maxWidth: double.infinity, // Set your maximum width here
            ),
            child: Container(
              margin: const EdgeInsets.all(41.0),
              child: Form(
                //key: widget.keyForm,
                child: formUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }




  void showDialogValidFields(String? msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Widget ContactoRefererencia = MenudeOpcionesOffline(Respuesta());
                          Navigator.push(
                            context,
                            //MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                            MaterialPageRoute(builder: (context) =>  ContactoRefererencia),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    msg.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )),
                              const Icon(
                                Icons.save,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )));
        });
  }

  void htmlAgregado(String htmlcode) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeTitulo.formItemsDesign(
                          "Se agrego el codigo HTML ${htmlcode}"),
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

  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {
    widget.formGestorSocialCtrl!.clear(); //1
    widget.formDNICtrl!.clear(); //2
    widget.formNombresApeCtrl!.clear(); //3
    widget.formPadronCtrl!.clear(); //4
    widget.formTiempoCtrl!.clear(); //5
    widget.formPensionTiempoCtrl!.clear(); //6
    widget.formNecesidadesCtrl!.clear(); //7
    widget.formEstablecimientoSaludCtrl!.clear(); //8
    widget.formSeAtendioCtrl!.clear(); //9
    widget.formServicioAtencionCtrl!.clear(); //10
    widget.formData = Respuesta();

    setState(() {
      Fase1 = false;
      Fase2 = true;
      Fase3 = false;
      Fase4 = false;
    });

  }

  Widget formUI() {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [

          Visibility(
            visible: Fase1,
            child:Column(
              children: <Widget>[

          HelpersViewLetrasRojas.formItemsDesign( "Seleccione motivo de Visita Colectiva"),
          const SizedBox(height: 16.0),

          //LISTA MOTIVOS
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                  items: widget.listMotivo.map((dep) {
                    return DropdownMenuItem(
                      value: dep,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          dep,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) async {

                    if(value == "Seleccionar un gestor social") {
                      widget.formGestorSocialCtrl.text = "";
                    } else {
                      widget.formGestorSocialCtrl.text = value!.isEmpty || value == null ? "" : value!;
                    }
                  },
                  validator: (value) => HelpersViewBlancoIcon.validateField(
                      widget.formGestorSocialCtrl.text!,
                      widget.ParamGestor),
                  isDense: true,
                  isExpanded: true,
                  //hint: const Text("Seleccione un motivo de Visita"),
                  value: widget.listMotivo.elementAt(widget.listMotivo.indexOf(widget.formGestorSocialCtrl.text) == -1 ? 0 : widget.listMotivo.indexOf(widget.formGestorSocialCtrl.text))
              )
          ),

          GestureDetector(
              onTap: ()  {

                if( widget.formGestorSocialCtrl.text == "" || widget.formGestorSocialCtrl!.text.isEmpty){
                  //NOPASA
                } else {
                  print("widget.formGestorSocialCtrl.text");
                  print(widget.formGestorSocialCtrl.text);
                  setState(() {
                    Fase1 = false;
                    Fase2 = true;
                  });
                }

              },
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Color(0xFFD60000),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text("Continuar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),


              ],),
          ),

          Visibility(
            visible: Fase2,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "Datos Generales de la Persona Usuaria"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "Ingrese el DNI:"),
                HelpersViewBlancoIcon.formItemsDesign(
                    Icons.person,
                    TextFormField(
                      controller: widget.formDNICtrl,
                      decoration: const InputDecoration(
                        labelText: 'Escriba su respuesta',
                      ),
                      /*validator: (value) {
                        return HelpersViewBlancoIcon.validateField(
                            value!, widget.ParamGrifoCtrl);
                      }, */
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 8,
                    ), context),

                HelpersViewLetrasSubs.formItemsDesign( "Ingrese Nombres y Apellidos:"),
                HelpersViewBlancoIcon.formItemsDesign(
                    Icons.person,
                    TextFormField(
                      controller: widget.formNombresApeCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Escriba su respuesta',
                      ),
                      /*
                      validator: (value) {
                        return HelpersViewBlancoIcon.validateField(
                            value!, widget.ParamGrifoCtrl);
                      }, */
                      maxLength: 100,
                    ), context),

                GestureDetector(
                    onTap: ()  {

                      if(
                      (widget.formDNICtrl.text == "" || widget.formDNICtrl!.text.isEmpty) ||
                      (widget.formNombresApeCtrl.text == "" || widget.formNombresApeCtrl!.text.isEmpty)
                      ){
                        //NOPASA
                        } else {
                        setState(() {
                          Fase2 = false;
                          Fase3 = true;
                        });
                      }



                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFFD60000),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Continuar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),


              ],),
          ),


          Visibility(
            visible: Fase3,
            child:Column(
              children: <Widget>[
                HelpersViewLetrasRojas.formItemsDesign( "Haga click en el satelite si esta rojo, y luego en el diskete para enviar"),
                /*
                HelpersViewLetrasRojas.formItemsDesign( "* Obligatorio"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Usted ha realizado el cobro correspondiente al último padrón *"),
                HelpersViewLetrasSubs.formItemsDesign( "Usualmente ¿Cada cuánto tiempo cobra la pensión? *"),

                GestureDetector(
                    onTap: ()  {
                      print("SIGUIENTE FASE");
                      setState(() {
                        Fase3 = false;
                        Fase4 = true;
                      });

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFFD60000),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Continuar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),

                */

              ],),
          ),


          Visibility(
            visible: Fase4,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "VALORACION SOCIO FAMILIAR - OBSERVACION DEL GESTOR"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿CON QUIÉN VIVE USTED? *"),
                HelpersViewLetrasSubs.formItemsDesign( "¿USTED TIENE AMIGOS, FAMILIARES, VECINOS A LOS QUE SUELE VISITAR? *"),



              ],),
          ),



        ],),
    );
  }
}
