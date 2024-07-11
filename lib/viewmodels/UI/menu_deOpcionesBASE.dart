import 'dart:async';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/database/database.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaunovisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUPunovisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/constantes.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewLetrasSubsGris.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources_apis.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_login.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/viewmodels/form_viewsmodel_formulario.dart';
import '../../infraestructure/dao/formdatamodeldao_padron.dart';
import '../../model/t_insertarEncuestaRSPTA.dart';
import '../../model/t_padron.dart';
import '../../model/visitaDomiciliaria/t_respBackupprimeravisita.dart';
import '../../utils/helpersviewAlertFaltaMSG.dart';
import '../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../utils/helpersviewAlertProgressCircle.dart';
import '../../utils/helpersviewBlancoIcon.dart';
import '../../utils/helpersviewBlancoSelect.dart';
import '../../utils/helpersviewLetrasRojas.dart';
import '../../utils/helpersviewLetrasSubs.dart';
import '../../utils/helperviewCabecera.dart';
import 'menu_deOpcionesLISTADO.dart';


class MenudeOpcionesBase extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuestaunovisita get formDataModelDao => _appDatabase.formDataModelDaoRespuesta;
  FormDataModelDaoRespuestaBACKUPunovisita get formDataModelDaoBackup => _appDatabase.formDataModelDaoRespuestaBACKUP;

  //PADRON
  FormDataModelDaoPadron get padronsql => _appDatabase.formDataModelDaoPadron;

  GlobalKey<FormState> keyForm = GlobalKey();
  //SIGUIENTE
  TextEditingController formIdUsuario = TextEditingController();
  TextEditingController formNombreUsuario = TextEditingController();

  //P03
  TextEditingController formP03EspecificarCtrl = TextEditingController();
  final ParamP03EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP06EspecificarCtrl = TextEditingController();
  final ParamP06EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP08EspecificarCtrl = TextEditingController();
  final ParamP08EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP09EspecificarCtrl = TextEditingController();
  final ParamP09EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP17EspecificarCtrl = TextEditingController();
  final ParamP17EspecificarCtrl = List.filled(3, "", growable: false);

  //BACKUP
  bool backup = false;



  //SIGUIENTE

  final ParamGestor = List.filled(3, "", growable: false);


  //ENVIAR LA DATA
  apiprovider_formulario apiForm = apiprovider_formulario();
  RespuestaPrimeraVisita? formData;
  RespuestaBACKUPprimeravisita? formDataBACKUP = RespuestaBACKUPprimeravisita();
  MenudeOpcionesBase(this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesBase();
  }

}



class _MenudeOpcionesBase extends State<MenudeOpcionesBase> {

  //ANTES TENIAN LATE
  String? PREFname;
  String? PREFapPaterno;
  String? PREFapMaterno;
  String? PREFnroDoc;
  String? PREFtypeUser;
  String? PREFtoken;

  int? Puntossumados = 0;

  String? GPSlatitude = "";
  String? GPSlongitude = "";
  String? GPSaltitude = "";

  String rpstP01 = "P01 ";
  String rpstP02 = " P02 ";
  String rpstP03 = " P03 ";
  String rpstP04 = " P04 ";
  String rpstP05 = " P05 ";
  String rpstP06 = " P06 ";
  String rpstP07 = " P07 ";
  String rpstP08 = " P08 ";
  String rpstP09 = " P09 ";
  String rpstP10 = " P10 ";
  String rpstP11 = " P11 ";
  String rpstP12 = " P12 ";
  String rpstP13 = " P13 ";
  String rpstP14 = " P14 ";
  String rpstP15 = " P15 ";
  String rpstP16 = " P16 ";
  String rpstP17 = " P17 ";
  String rpstP18 = " P18 ";
  int puntaje = 0;

  //BACKUP
  List <RespuestaBACKUPprimeravisita> listBackup = List.empty();

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
    revisarBackup();
    if(widget.formData != null) {


    }

    // TODO: implement initState
    super.initState();
  }

  bool isSatelliteGreen=false;

  bool Fase1 = true;
  bool Fase2 = false;
  bool Fase3 = false;
  bool Fase4 = false;
  bool Fase5 = false;
  bool Fase6 = false;


  Future<void> revisarBackup() async {

    if (widget.formDataBACKUP != null) {
      widget.formDataBACKUP!.cod = 0;
    }


    listBackup = await widget.formDataModelDaoBackup.findAllRespuesta();
    setState(() {
      if(listBackup.isNotEmpty){
        widget.backup = true;
        //objBackup = listBackup[0];
      } else {
        widget.backup = false;
      }
    });
  }

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

  Future<void> guardadoFase1() async{

    widget.formData?.id_usuario =  widget.formIdUsuario!.text;
    widget.formDataBACKUP?.id_usuario = widget.formIdUsuario!.text;
    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }


  Future<void> guardadoFase2() async{

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase3() async{

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase4() async{

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase5() async{

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
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
  final _mostrarLoadingStreamControllerPuntaje = StreamController<int>.broadcast();
  void CargaDialog() {
    bool mostrarLOADING = false;
    int puntajeLOADING = 0;
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

            _mostrarLoadingStreamControllerPuntaje.stream.listen((value) {
              setState(() {
                puntajeLOADING = value;
              });
            });

            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    HelpersViewAlertProgressCircle(
                      mostrar: mostrarLOADING,
                      puntaje: puntajeLOADING,
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
    final scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          Constants.tituloMenudeOpciones,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 65, 187),
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
                                MaterialPageRoute(builder: (context) => MenudeOpcionesListado()),
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

          //GUARDAR FORMULARIO BOTON DISKETE
          IconButton(
            icon: Image.asset(Resources.guardar),
            color: Colors.white,
            onPressed: () async {
              if ( GPSlongitude != "") {
                if (!Fase6) {
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                } else {
                  CargaDialog(); //INICIALIZA DIALOGO

                  String respuestas = "";


                  respuestas = ''
                      'Respuestas:'
                      '$rpstP01$rpstP02$rpstP03$rpstP04$rpstP05$rpstP06$rpstP07'
                      '$rpstP08$rpstP09$rpstP10$rpstP11$rpstP12$rpstP13$rpstP14'
                      '$rpstP15$rpstP16$rpstP17$rpstP18'
                      '- Nombre:$PREFname,'
                      '- Appaterno:$PREFapPaterno,'
                      '- MatMaterno:$PREFapMaterno,'
                      '- DNI:$PREFnroDoc,'
                      '- TipoUsuario:$PREFtypeUser,'
                  ;

                  //RELLENANDO
                  widget.formData?.idformato = apisResources.api_idFormato;
                  widget.formData?.id_gestor = int.parse(PREFnroDoc!);
                  widget.formData?.fecha = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.respuestas = respuestas;
                  widget.formData?.puntaje =  puntaje;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  widget.formData?.id_usuario = widget.formIdUsuario.text;
                  //GPSlatitude

                  //FUNCION PARA SINCRONIZAR
                  //insertarEncuestaRSPTA rpta = await widget.apiForm.post_EnviarRspt(widget.formData!, PREFtoken);

                  //await GuardarFormulario();

                    await widget.formDataModelDaoBackup.BorrarTodo();

                  await widget.formDataModelDao.insertFormDataModel(widget.formData!);
                  cleanForm();
                  _mostrarLoadingStreamController.add(true);
                  _mostrarLoadingStreamControllerPuntaje.add(puntaje);

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
          controller: scrollController,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 440.0, // Set your minimum width here
              maxWidth: double.infinity, // Set your maximum width here
            ),
            child: Container(
              margin: const EdgeInsets.all(41.0),
              child: Form(
                //key: widget.keyForm,
                child: formUI(scrollController),
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
                          Navigator.pop(context);
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


  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {

    setState(() {

    });

  }

  void NoEncontradoDNI(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeFOTO.formItemsDesign(
                          "No existe un padron con el DNI ingresado", "DNI no encontrado"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Align row to the end
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  )));
        });
  }

  Widget formUI(ScrollController scrollController) {

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

                HelpersViewLetrasRojas.formItemsDesign( "Inicio del cuestionario"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "Gestor social: ${PREFname} ${PREFapPaterno} ${PREFapMaterno}"),

                //PONER AQUI


                                //DNI & BUSCAR
                Row(
                  children: [

                    const Text('DNI:', style: TextStyle(
                      fontSize: 12.0,
                      //color: Colors.white,
                    ),),

                    HelpersViewBlancoIcon.formItemsDesignDNI(
                        TextFormField(
                          controller: widget.formIdUsuario,
                          decoration: const InputDecoration(
                            labelText: 'DNI del Usuario',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          /*
                      validator: (value) {
                        return HelpersViewBlancoIcon.validateField(
                            value!, widget.formIdUsuario);
                      }, */
                          maxLength: 8,
                        ), context),

                    IconButton(
                      icon: Image.asset(Resources.lupa),
                      color: Colors.white,
                      onPressed: () async {
                        List<Padron> padronObj;
                        Padron padronSelect;
                        padronObj = await widget.padronsql.findAllPadronDNI(widget.formIdUsuario.text);

                        if(padronObj.isNotEmpty){
                          padronSelect = padronObj[0];
                          String? nombreObj =  '${padronSelect.nombre} ${padronSelect.apPaterno} ${padronSelect.apMaterno}';
                          setState(() {
                            widget.formNombreUsuario.text = nombreObj!;
                          });

                        } else {
                          widget.formNombreUsuario!.clear();
                          NoEncontradoDNI(context);
                        }

                      },
                    ),

                  ],
                ),



                HelpersViewBlancoIcon.formItemsDesign(
                    Icons.person,
                    TextFormField(
                      controller: widget.formNombreUsuario,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del Usuario',
                      ),
                      /*
                      validator: (value) {
                        return HelpersViewBlancoIcon.validateField(
                            value!, widget.formNombreUsuario);
                      }, */
                      maxLength: 35,
                    ), context),

                GestureDetector(
                    onTap: ()  async {

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                      if( widget.formIdUsuario.text != null && widget.formIdUsuario.text != "" ){
                        await guardadoFase1();
                        setState(() {
                          Fase1 = false;
                          Fase2 = true;
                        });
                      } else {
                        showDialogValidFields(Constants.faltanCampos);
                      }


                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Iniciar formulario",
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

                //BOTON PARA PRESEGUIR

                GestureDetector(
                    onTap: ()  async {

                      if( 1 == 2
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase2();
                        setState(() {
                          Fase2 = false;
                          Fase3 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );


                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
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


                GestureDetector(
                    onTap: ()  async {
                      if( 1 == 2){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase3();
                        setState(() {
                          Fase3 = false;
                          Fase4 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
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
            visible: Fase4,
            child:Column(
              children: <Widget>[


                //BOTON DE SUBIR
                GestureDetector(
                    onTap: ()  async {
                      if( 1 == 2
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase4();
                        setState(() {
                          Fase4 = false;
                          Fase5 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
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
            visible: Fase5,
            child:Column(
              children: <Widget>[

                GestureDetector(
                    onTap: ()  async {
                      if( 1 == 2
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase5();
                        setState(()  {
                          Fase5 = false;
                          Fase6 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Finalizar el formulario",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),


              ],),
          ),


          Visibility(
            visible: Fase6,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasSubs.formItemsDesign( "Para mejorar la precisión de la coordenada presioné icono del satélite, luego guarde su cuestionario presionando el icono diskette."),

              ],),
          ),

        ],),
    );
  }
}
