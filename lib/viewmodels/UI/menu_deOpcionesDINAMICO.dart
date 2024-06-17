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
  final viewModel = FormDataModelViewModel();
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

  //BACKUP
  bool backup = false;

  //FORMULARIOS DINAMCIOS
  int? total = 0;
  int? totalFase2 = 0;

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

enum EstadoFallecido { Si, No } //SOLO SIRVE PARA MOSTRAR NO SE GUARDA

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
    widget.viewModel
      ..listen()
      ..getPaginationList();
    loadTotalRegister();

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

  EstadoFallecido? _EstadoFallecido = null;

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
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
    var res = await widget.formDataModelDaoFormulario.totalFormDataModels();
    setState(() {
      widget.total = res;
    });
  }

  Future<void> listarVisitasRetro() async {
    widget.viewModel
      ..listen()
      ..getPaginationList();
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

                HelpersViewLetrasRojas.formItemsDesign( "Formulario (* Obligatorio)"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "INSERTAR SUB *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                //FORMULARIO FASE2
                SizedBox(
                  width: double.infinity, // Fills available space horizontally
                  height: 350, // Set your desired height
                  child: AnimatedInfiniteScrollView<Formulario>(
                    viewModel: widget.viewModel,
                    itemBuilder: (context, index, item) {

                      bool MostrarInput = false;
                      bool MostrarOpcion = false; //false opcion multiple //true checkbox


                      List<String>? tipoOpcionList;
                      if (item.id_tipo_respuesta == 4 ||
                          item.id_tipo_respuesta == 5) {
                        tipoOpcionList = item.tipoOpcion!.split(',');
                      } else {
                        MostrarInput = true;
                      }

                      return Column(
                        children: [

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.010,
                          ),

                          Text(
                            "${index + 1}) ${item.pregunta}:  ${item.texto}", // Example,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "${item.descripcion}", // Example,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black12,
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.010,
                          ),

                          //INPUT TEXT
                          Visibility(
                            visible: MostrarInput,
                            child:
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
                          ),

                          //OPCIONES CIRCLE
                          Visibility(
                            visible: !MostrarInput,
                            child:
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
                                        Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Text(
                                            "Opción ${index+1}) ${tipoOpcionList?[index]}",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.fade,
                                            maxLines: 2, // Set the number of lines here
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        //Icon(iconValue, color: Colors.red,),

                                        const SizedBox(height: 16.0), // Add spacing between text and radio
                                        Radio<EstadoFallecido>(
                                          value: EstadoFallecido.Si,
                                          groupValue: _EstadoFallecido,
                                          onChanged: (EstadoFallecido? value) {
                                            setState(() {
                                              _EstadoFallecido = value;
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
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.020,
                          ),

                        ],
                      );

                    },
                    refreshIndicator: true,
                  ),
                ),

                //BOTON PARA CONTINUAR

                GestureDetector(
                    onTap: ()  async {

                      if(
                      (1 == 1) ||
                      (1 == 1)
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase2();
                        setState(() {
                          Fase2 = false;
                          Fase3 = true;
                        });
                        scrollController.animateTo(
                            0.0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,);
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

                HelpersViewLetrasRojas.formItemsDesign( "SALUD"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "Actualmente. ¿A qué tipo de establecimiento de Salud, acude con frecuencia? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

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
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),


              ],),
          ),

          Visibility(
            visible: Fase5,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "Tipo de Vivienda"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Que tipo de vivienda tienes? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

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
