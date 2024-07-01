import 'dart:async';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/database/database.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuesta.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUP.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respBackup.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuesta.dart';
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
import '../../utils/helpersviewAlertFaltaMSG.dart';
import '../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../utils/helpersviewAlertProgressCircle.dart';
import '../../utils/helpersviewBlancoIcon.dart';
import '../../utils/helpersviewLetrasRojas.dart';
import '../../utils/helpersviewLetrasSubs.dart';
import '../../utils/helperviewCabecera.dart';
import 'menu_deOpcionesLISTADO.dart';


class MenudeOpcionesDinamico extends StatefulWidget {
  //final viewModel = FormDataModelViewModel();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuesta get formDataModelDao => _appDatabase.formDataModelDaoRespuesta;
  FormDataModelDaoRespuestaBACKUP get formDataModelDaoBackup => _appDatabase.formDataModelDaoRespuestaBACKUP;
  FormDataModelDaoFormulario get formDataModelDaoFormulario => _appDatabase.formDataModelDaoFormulario;

  //PADRON
  FormDataModelDaoPadron get padronsql => _appDatabase.formDataModelDaoPadron;

  GlobalKey<FormState> keyForm = GlobalKey();
  //SIGUIENTE
  TextEditingController formIdUsuario = TextEditingController();
  TextEditingController formNombreUsuario = TextEditingController();

  final scrollControllerOPTIONS = ScrollController();

  //BACKUP
  bool backup = false;

  //FORMULARIOS DINAMCIOS
  int sumatoriacheck = 0; //GUARDA LO QUE SE SUMARA
  int auxsumatoriacheck = 0;  //AYUDA A MANTENER LOS ID

  int idbutton = 1;
  int? IDSECCION = 0;
  int? totalFase2 = 0;
  List<Formulario> listFormulario = List.empty(growable: true);

  final ParamGestor = List.filled(3, "", growable: false);

  //ENVIAR LA DATA
  apiprovider_formulario apiForm = apiprovider_formulario();
  Respuesta? formData;
  RespuestaBACKUP? formDataBACKUP = RespuestaBACKUP();
  MenudeOpcionesDinamico(this.formData, {super.key});


  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesDinamico();
  }

}

//DINAMISMO
class RadioButtonsDinamic {
  final int name;
  final bool bol;
  final int puntaje;
  RadioButtonsDinamic(this.name,  this.bol,  this.puntaje);

  static List<RadioButtonsDinamic> generateData(int count) {
    List<RadioButtonsDinamic> data = [];
    for (int i = 0; i < count; i++) {
      data.add(RadioButtonsDinamic(i+1, true, 0)); // Adjust 'si' value as needed
    }
    return data;
  }
}

enum idDinamico { a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, x, y, z, noRpta } //SOLO SIRVE PARA MOSTRAR NO SE GUARDA

class _MenudeOpcionesDinamico extends State<MenudeOpcionesDinamico> {

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

  int puntaje = 0;

  //BACKUP
  List <RespuestaBACKUP> listBackup = List.empty();

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
    //widget.viewModel
    //  ..listen()
    //  ..getPaginationList();
    loadTotalRegister();
    listarVisitasRetro();

    if(widget.formData != null) {
      if (widget.formData!.id_gestor != null) {
        setState(() {
          widget.formIdUsuario!.text = widget.formData!.id_usuario!.toString();
        });
      }
    }
    // TODO: implement initState
    super.initState();
  }

  //idDinamico? _idDinamico = null;
  List<idDinamico> _idDinamicoListInput = [];
  List<idDinamico> _idDinamicoListCircle = [];
  List<bool> _idDinamicoListCheck = [];


/*
  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  } */

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
    widget.formData?.id_usuario =  int.parse(widget.formIdUsuario!.text);
  }

  Future<void> guardadoFase2() async{
    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase3() async{
    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase4() async{
    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase5() async{
    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
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

  //FORMULARIOS
  Future<void> loadTotalRegister() async {
    //var res = await widget.formDataModelDaoFormulario.totalFormDataModels();
    var res = await widget.formDataModelDaoFormulario.totalFormDataModelsSECCION(widget.IDSECCION!);

    //findFormDataModelSECCION; AGREGAR LA SEPARACION POR SECCIONES


    var resRADIO = await widget.formDataModelDaoFormulario.totalFormDataModelsCIRCLE();
    //PARA RADIOBUTTON
    if(resRADIO!>0){
      for (int i = 0; i < resRADIO!; i++) {
        _idDinamicoListCircle .add(idDinamico.noRpta);
      }}

    var resCHECK = await widget.formDataModelDaoFormulario.totalFormDataModelsCHECKS();
    List<Formulario> listcheck = await widget.formDataModelDaoFormulario.findAllFormularioCHECK();
    //PARA CHECKBOX
      if(listcheck.isNotEmpty){
        for (int i = 0; i < listcheck.length; i++) {
          List<String>? OpcionCHECKcount;
          OpcionCHECKcount = listcheck[i].tipoOpcion!.split(';');
            for (int i = 0; i < OpcionCHECKcount.length; i++) {
              _idDinamicoListCheck .add(false);
            }
        }}

    var resINPUT = await widget.formDataModelDaoFormulario.totalFormDataModelsINPUT();
    //PARA INPUT
        if(resINPUT!>0){
          for (int i = 0; i < resINPUT!; i++) {
            _idDinamicoListInput .add(idDinamico.noRpta);
          }}


    setState(() {});
  }

  Future<void> listarVisitasRetro() async {

    widget.listFormulario = await widget.formDataModelDaoFormulario.findFormDataModelORIGINAL();
    //TALVEZ VALAL TALVEZ NO
    /*
    widget.viewModel
      ..listen()
      ..getPaginationList(); */
    setState(() {});
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

                  //RELLENANDO
                  widget.formData?.idformato = apisResources.api_idFormato;
                  widget.formData?.id_gestor = int.parse(PREFnroDoc!);
                  widget.formData?.fecha = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.respuestas = respuestas;
                  widget.formData?.puntaje =  puntaje;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  widget.formData?.id_usuario = int.parse(widget.formIdUsuario.text);

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
              margin: const EdgeInsets.all(22.0),
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
      Fase1 = true;
      Fase2 = false;
      Fase3 = false;
      Fase4 = false;
      Fase5 = false;
      Fase6 = false;

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

                HelpersViewLetrasRojas.formItemsDesign( "Módulo II: USUARIO Y CUIDADOR"),
                const SizedBox(height: 10.0),

                //HelpersViewLetrasSubs.formItemsDesign( "INSERTAR SUB *"),
                //HelpersViewLetrasSubs.formItemsDesign(Constants.circleAviso),

                /*  AnimatedInfiniteScrollView<Formulario>( //CAMBIAR LA LISTA POR ITEM
                    viewModel: widget.viewModel,
                    itemBuilder: (context, index, item) {*/

            Container(  // Container with border around the Row
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide( // Border for all sides
                  color: Colors.red, // Change color as desired
                  width: 2.0, // Adjust border width
                ),),
              ),
            child:
            Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
                    child: widget.listFormulario.isNotEmpty
                        ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.listFormulario!.length,
                        itemBuilder: (context, index) {


                        String? ipregunta = "";
                        String? itexto = "";
                        String? idescripcion = "";
                        String? ititulo = "";

                        List<String>? tipoOpcionList;
                        List<String>? tipoOpcionPuntaje;
                        List<RadioButtonsDinamic> idOpciones = List.empty();
                        int indexPregunta =0;


                        widget.sumatoriacheck = widget.sumatoriacheck + widget.auxsumatoriacheck;


                        if( !(widget.listFormulario![index].pregunta == null)){ ipregunta = widget.listFormulario![index].pregunta!;}
                        if( !(widget.listFormulario![index].texto == null)){ itexto = widget.listFormulario![index].texto!;}
                        if( !(widget.listFormulario![index].descripcion == null)){ idescripcion = widget.listFormulario![index].descripcion!;}
                        if( !(widget.listFormulario![index].titulo == null)){ ititulo = widget.listFormulario![index].titulo!;}

                        if (widget.listFormulario![index].tipoRepuesta == 2 || //CIRCLE OPCION
                            widget.listFormulario![index].tipoRepuesta == 4) { //CHECKBOX
                          tipoOpcionList = widget.listFormulario![index].tipoOpcion!.split(';'); //ENUNCIADO
                          tipoOpcionPuntaje = widget.listFormulario![index].puntaje!.split(';'); //PUNTAJE
                          indexPregunta = index;
                          //idOpciones = RadioButtonsDinamic.generateData(tipoOpcionList.length); //GENERA ID

                          if(widget.listFormulario![index].tipoRepuesta == 4){ //CHECBOX
                            widget.auxsumatoriacheck = tipoOpcionList.length;
                            return Column(
                              children: [

                                //TODAS LAS PREGUNTAS ENUNCIADOS
                                HelpersViewLetrasRojas.formItemsPREGUNTA(index, ipregunta!, itexto!, idescripcion!,  context),

                                //OPCIONES CHECK
                                SizedBox(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: tipoOpcionList?.length ?? 0,
                                    itemBuilder: (context, index) {

                                      return Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide( // Apply color and width to the bottom side
                                              color: Colors.red, // Change this to your desired color
                                              width: 1.0,      // Adjust border width here
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${index+1}) ${tipoOpcionList?[index]}",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    //color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const Spacer(),
                                            //EN LA SGTE PREGUNTA AGARRA EL INDEX DE ARRIBA HACER SUMATORIA
                                            Checkbox(
                                              //value: _idDinamicoListCheck[index + widget.sumatoriacheck],
                                              value: _idDinamicoListCheck[index],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  //_idDinamicoListCheck[index + widget.sumatoriacheck] = value!;
                                                  _idDinamicoListCheck[index] = value!;
                                                });
                                              },
                                            ),

                                            SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.005,
                                            ),

                                          ],
                                        ),
                                      );

                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.020,
                                ),
                                Text(
                                  "${ititulo ?? ""}", // Example,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.020,
                                ),
                              ],
                            );

                          } else if (widget.listFormulario![index].tipoRepuesta == 2){ //CIRCLE

                            return Column(
                              children: [

                                //TODAS LAS PREGUNTAS ENUNCIADOS
                                HelpersViewLetrasRojas.formItemsPREGUNTA(index, ipregunta!, itexto!, idescripcion!,  context),

                                //OPCIONES CIRCLE
                                SizedBox(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: tipoOpcionList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide( // Apply color and width to the bottom side
                                              color: Colors.red, // Change this to your desired color
                                              width: 1.0,      // Adjust border width here
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${index+1}) ${tipoOpcionList?[index]}",
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    //color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const Spacer(),

                                            Radio<idDinamico>(
                                              value: idDinamico.values[index],
                                              groupValue: _idDinamicoListCircle[indexPregunta], //
                                              onChanged: (idDinamico? value) {
                                                setState(() {
                                                  _idDinamicoListCircle[indexPregunta] = value!;
                                                });
                                              },
                                            ),

                                            SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.005,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.020,
                                ),
                                Text(
                                  "${ititulo ?? ""}", // Example,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.020,
                                ),
                              ],
                            );

                          }

                        } else {
                          //MOSTRAR INPUT
                          return  Column(
                            children: [

                              //TODAS LAS PREGUNTAS ENUNCIADOS
                              HelpersViewLetrasRojas.formItemsPREGUNTA(index, ipregunta!, itexto!, idescripcion!,  context),

                              //INPUT TEXT
                              HelpersViewBlancoIcon.formItemsDesign(
                                Icons.question_mark,
                                TextFormField(
                                  // Access item data here
                                  decoration: InputDecoration(
                                    //labelText:"${item.tipoRepuesta}",
                                    labelText:"Ingresar respuesta única",
                                  ),
                                ),
                                context,
                              ),


                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.020,
                              ),
                              Text(
                                "${ititulo ?? ""}", // Example,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.020,
                              ),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.020,),
                          ],
                        );

                      },
                    )
                        : const Text('Aún no hay data para mostrar')
                ),
                Spacer(),
              ]),),



                //BOTON PARA CONTINUAR
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),


              ],),
          ),


          Visibility(
            visible: Fase3,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "SALUD"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "Actualmente. ¿A qué tipo de establecimiento de Salud, acude con frecuencia? *"),
                HelpersViewLetrasSubs.formItemsDesign(Constants.circleAviso),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                GestureDetector(
                    onTap: ()  async {
                      if(
                      (1 == 1) ||
                      (1 == 1)
                      ){
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

                HelpersViewLetrasRojas.formItemsDesign( "VALORACION SOCIO FAMILIAR - OBSERVACION DEL GESTOR"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Con quién vive usted? *"),
                HelpersViewLetrasSubs.formItemsDesign(Constants.circleAviso),


              ],),
          ),

          Visibility(
            visible: Fase5,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "Tipo de Vivienda"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Que tipo de vivienda tienes? *"),
                HelpersViewLetrasSubs.formItemsDesign(Constants.circleAviso),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                GestureDetector(
                    onTap: ()  async {
                      if(
                      (1 == 1) ||
                          (1 == 1)
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
