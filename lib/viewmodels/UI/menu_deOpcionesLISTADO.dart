import 'dart:async';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_padronLogin.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpciones.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpcionesDINAMICO.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpcionesPERCEPCION.dart';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_menuOpciones.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/database/database.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_padron.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuesta.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUP.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuesta.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_padron.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/utils/bakcupMapper.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/utils/respuestaMapper.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/constantes.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewAlertProgressCircleLOGIN.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_login.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/viewmodels/form_viewsmodel_respuesta.dart';


import '../../main.dart';
import '../../model/t_padronlogin.dart';
import '../../model/t_respBackup.dart';
import '../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../utils/helpersviewAlertProgressSinc.dart';
import '../../utils/helpersviewBlancoIcon.dart';
import 'menu_deOpcionesOFFLINE.dart';


class MenudeOpcionesListado extends StatefulWidget {
  final viewModel = FormDataModelViewModel();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  apiprovider_formulario apiForm = apiprovider_formulario();
  FormDataModelDaoRespuesta get formDataModelDaoRespuesta => _appDatabase.formDataModelDaoRespuesta;
  FormDataModelDaoPadron get formDataModelDaoPadron => _appDatabase.formDataModelDaoPadron;
  FormDataModelDaoPadronLogin get formDataModelDaoPadronLogin => _appDatabase.formDataModelDaoPadronLogin;
  FormDataModelDaoRespuestaBACKUP get formDataModelDaoBackup => _appDatabase.formDataModelDaoRespuestaBACKUP;
  FormDataModelDaoFormulario get formDataModelDaoFormulario => _appDatabase.formDataModelDaoFormulario; //ENCUESTA PERCEPCIONES

  List<Formulario> listForm = List.empty(growable: true);
  MenudeOpcionesListado({Key? key});

  int? totalPadrones = 0;

  int? total = 0;
  int? page = 1;
  int? totalPage = 0;
  List<Respuesta> listRespuesta = List.empty(growable: true);

  String? nombrePadron = "";
  String? departamentoPadron = "";


  apiprovider_menuOpciones apiVersion = apiprovider_menuOpciones();
  //BACKUP
  bool backup = false;

  //FORMULARIO DINAMICO
  bool dinamico = false;

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesListado();
  }

}


class _MenudeOpcionesListado extends State<MenudeOpcionesListado> {

  late String PREFname;
  late String PREFapPaterno;
  late String PREFapMaterno;
  late String PREFnroDoc;
  late String PREFtypeUser;
  late String PREFtoken;
  late String PREFdistrito;

late final _appDatabase;

  Future<void> initializeDatabase() async {
    _appDatabase = await GetIt.I.get<AppDatabase>();
  }

  //BACKUP
  List <RespuestaBACKUP> listBackup = List.empty();
  late RespuestaBACKUP objBackup;

  Future<void> listarVisitasAvanzar() async {
    if(widget.totalPage! != widget.page!) {
      widget.page = widget.page!+1;
    }
    var offset = (widget.page!*10)-10;
    if(offset < 0) {
      offset = 0;
    }
    widget.listRespuesta = await widget.formDataModelDaoRespuesta.findFormDataModel(offset, 10);
    setState(() {});
  }

  Future<void> conseguirVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      PREFname = prefs.getString('name') ?? "Nulo";
      PREFapPaterno = prefs.getString('apPaterno') ?? "Nulo";
      PREFapMaterno = prefs.getString('apMaterno') ?? "Nulo";
      PREFnroDoc = prefs.getString('nroDoc') ?? "Nulo";
      PREFtypeUser = prefs.getString('typeUser') ?? "Nulo";
      PREFtoken = prefs.getString('token') ?? "Nulo";
      PREFdistrito = prefs.getString('distrito') ?? "Nulo";
    });

    if(PREFtoken == "ERROR"){
      showDialogValidFields("El token no se ha recibido");
    }
  }

  Future<void> revisarBackup() async {
    listBackup = await widget.formDataModelDaoBackup.findAllRespuesta();
    setState(() {
      if(listBackup.isNotEmpty){
        widget.backup = true;
        objBackup = listBackup[0];
      } else {
        widget.backup = false;
      }
    });
  }

  Future<void> revisarPercepciones() async {
    var percepcionesDinamico = await widget.formDataModelDaoFormulario.totalFormDataModels();
    setState(() {
      if(percepcionesDinamico! > 0){
        widget.dinamico = true;
      }
    });
  }



  @override
  void initState() {
    revisarBackup();
    revisarPercepciones();
    conseguirVersion();
    widget.viewModel
    ..listen()
    ..getPaginationList();
    verificarLogeoAnterior();
    loadTotalRegister();
    loadTotalPadrones();
    listarVisitasRetro();
    // TODO: implement initState
    super.initState();
  }

  Future<void> verificarLogeoAnterior() async {
    int resp = 0;
    int? res = await widget.formDataModelDaoPadronLogin.totalFormDataModels();
    resp = res!;
    if(resp>0) {
      List<PadronLogin> lista = await widget.formDataModelDaoPadronLogin
          .findAllPadronLogin();
      PadronLogin padronObj = PadronLogin();
      padronObj = lista[0];

      setState(() {
        widget.nombrePadron = "${padronObj.nombre} ${padronObj.apellidos}" ;
        widget.departamentoPadron = padronObj.hogarDepartamento;
      });
    }
  }

  int calcularTotalPaginas(int totalRegistros, int registrosPorPagina) {
    // Calcula el total de páginas
    int totalPaginas = totalRegistros ~/ registrosPorPagina;

    // Si hay registros adicionales que no llenan una página completa,
    // agrega una página adicional
    if (totalRegistros % registrosPorPagina > 0) {
      totalPaginas++;
    }

    return totalPaginas;
  }


  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  Future<void> loadTotalRegister() async {
    var res = await widget.formDataModelDaoRespuesta.totalFormDataModels();
    setState(() {
      widget.total = res;
    });
  }

  Future<void> loadTotalPadrones() async {
    var res = await widget.formDataModelDaoPadron.totalFormDataModels();
    setState(() {
      widget.totalPadrones = res;
    });
  }


  Future<void> listarVisitasRetro() async {
    widget.viewModel
      ..listen()
      ..getPaginationList();

    var pages = widget.page!-1;
    if(pages > 0) {
      widget.page = pages;
    }
    var offset = (widget.page!*10)-10;
    if(offset < 0) {
      offset = 0;
    }
    widget.listRespuesta = await widget.formDataModelDaoRespuesta.findFormDataModel(offset, 10);
    widget.totalPage = calcularTotalPaginas(widget.total!, 10);
    print("GEORGE3");
        
    setState(() {});
  }

  //POR SI BORRO
  void actualizarTotalConTemporizador(int nuevoTotal) {
    Timer(Duration(seconds: 1), () {
      setState(() {
        widget.total = nuevoTotal;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          Constants.tituloMenudeOpcionesListado,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 27, 65, 187),
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
                            child: Text('Sí',
                              style: TextStyle(
                                fontSize: 18, // Tamaño de fuente deseado
                              ),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cierra el diálogo
                            },
                            child: Text('No',
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
            icon: Image.asset(Resources.iconSincronizar),
            color: Colors.white,
            onPressed: () async {
              SincronizarDialog();
            },
          ),

          /*
          IconButton(
            icon: Image.asset(
              !widget.dinamico
                  ? Resources.iconProgreso
                  : Resources.fotoX,
              // Usa la imagen verde si isSatelliteGreen es verdadero, de lo contrario, usa la imagen roja
            ),
            color: Colors.white,
            onPressed: () async {

              if(!widget.dinamico){
                CargaDialog(); //PANTALLA DE CARGA
                if(PREFtoken == "ERROR"){
                  showDialogValidFields("El token no se ha recibido");
                } else {
                  List<Formulario> InsertarFormularioENTITY = await widget.apiForm.post_FormularioLista(PREFtoken);
                  print(InsertarFormularioENTITY.length);
                  if(InsertarFormularioENTITY.length>0){
                    //BORRAR TODA LA DATA EXISTENTE
                    await widget.formDataModelDaoFormulario.BorrarTodo();
                    for (int i = 0; i < InsertarFormularioENTITY.length; i++) {
                      try {
                        await widget.formDataModelDaoFormulario.insertFormDataModel(InsertarFormularioENTITY[i]);
                        print("AGREGADO FORMULARIO ${i}");
                      }  catch (error) {
                        print("Error saving FORMULARIO: $error");
                        _mostrarLoadingStreamController.add(true);
                        _mostrarLoadingStreamControllerTITUTLO.add("Error en el guardado");
                        _mostrarLoadingStreamControllerTEXTO.add("No se pudo guardar el formulario");
                      }
                    }
                    //TERMINO
                    _mostrarLoadingStreamController.add(true);
                    _mostrarLoadingStreamControllerTITUTLO.add("Descarga exitosa");
                    _mostrarLoadingStreamControllerTEXTO.add("Ya puede responder el formulario");
                    //showDialogValidFields("Sincronización exitosa");
                    setState(() {
                      widget.dinamico = true;
                    });

                  } else {
                    _mostrarLoadingStreamController.add(true);
                    _mostrarLoadingStreamControllerTITUTLO.add("Error en la base de datos");
                    _mostrarLoadingStreamControllerTEXTO.add("No se pudo descargar el formulario");
                    //showDialogValidFields("No se descargo la encuesta");
                  }
                }
              }else{
                //DESEA SOBREESCRIBRI?
                BorrarPercepcionesDialog();
              }



            },
          ),
*/
        ],
      ),
      body: Center (
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
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

  //ALERT DE SINCRONIZAR
  void SincronizarDialog(){
    String MensajeSinc = "Se sincronizara todo el listado";
    String MensajeSubSinc = "¿Desea sincronizar los registros?";
    bool mostrar = false;
    bool mostrarBoton = true;

    double progresso = 0.0;
    int progressoInicio = 0;
    int? progressoFin = widget.total;
    double sumando = 4.44;

    if (widget.total != 0) {
      sumando = (100/widget.total!)/100;
    }

    showDialog(
        context: context,
        builder: (context){
          //AGREGAR ESTO POR SI QUIERO QUE EL DIALOG SE REFRESQUE
          return StatefulBuilder(
              builder: (context, setState)
              {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    content: SingleChildScrollView(
                        child: Column(
                          children: [

                            //BARRA DE PROGRESO CON SU TITULO
                            HelpersViewAlertProgressSinc(
                                Mensaje: MensajeSinc,
                                subtexto: MensajeSubSinc,
                                progress: progresso,
                                mostrar: mostrar,
                                mostrarBoton: mostrarBoton,
                                contadorInicio: progressoInicio,
                                contadorFin: progressoFin
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // Align row to the end
                              children: [
                                Spacer(), // Push remaining space to the left

                                InkWell(
                                  onTap: () async {

                                    //INICIALIZA CARGA
                                    setState(() {
                                      mostrar = true;
                                      mostrarBoton = false;
                                      //progresso = 0.0;
                                      //progresso += (sumando);
                                      MensajeSinc = "Sincronizando Data";
                                      MensajeSubSinc = "$progressoInicio/$progressoFin";
                                    });

                                    //apiprovider_formulario apiForm = apiprovider_formulario();
                                    var iniciFinActividades = await widget._appDatabase.formDataModelDaoRespuesta.findAllRespuesta();
                                
                                    if (iniciFinActividades.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "No hay data para sincronizar")));
                                    } else {
                                      var listRespuestaApi = RespuestaMapper.instance.listRespuestaToRespuestaENVIO(iniciFinActividades);
                                      for (var element in listRespuestaApi) {
                                        var response = await widget.apiForm.post_EnviarRspt(element,PREFtoken);
                                      
                                         print("atento4333");
                                         print(listRespuestaApi);
                                        print("response: $response");

                                        //BORRA LA SENTENCIA
                                        // if(response.codigo == "0105"){
                                        if(response.codigo != "0000"){
                                          print("ENVIO BIEN SUPONGO");
                                          //NO BORRA PORQUE NO TENGO UN CODIGO!
                                          //widget._appDatabase.formDataModelDaoRespuesta.BorrarFormDataModels(element.cod!);
                                        }

                                        //AUMENTA
                                        setState(() {
                                          //mostrar = true;
                                          //progresso = 0.0;
                                          progresso += (sumando);
                                          progressoInicio++;
                                          MensajeSubSinc = "$progressoInicio/$progressoFin";
                                        });

                                      }

                                      Navigator.pop(
                                          context); //Close your current dialog
                                      showDialogValidFields(
                                          "Sincronización exitosa");

                                      listarVisitasRetro();
                                      //Navigator.of(context).pop();

                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20, bottom: 20),
                                    child: const Text(
                                      "Sincronizar",
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
    );

  }

  //ALERT DE BORRAR - MODIFICAR!
  void ModificarBorrar(int index, Respuesta obj) {
    String titulo = "Encuesta dirigida a la persona Usuaria";
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeFOTO.formItemsDesign("${index + 1})  ${obj.fecha}\n$titulo\n${obj.id_usuario}\n${obj.respuestas}","¿Que acción desea realizar?"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align row to the end
                        children: [
                          Spacer(), // Push remaining space to the left


                          InkWell(
                            onTap: () {
                                  Widget ContactoRefererencia = MenudeOpcionesOffline(obj); //CARGO DATA
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  ContactoRefererencia), //VOY AHI
                                  );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Modificar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: ()   async {
                              widget.formDataModelDaoRespuesta.BorrarFormDataModels(obj.cod!);
                              widget.viewModel.deleteItem(index);
                              Navigator.of(context).pop();
                              var nuevoTotal = widget.total;
                              actualizarTotalConTemporizador(nuevoTotal! - 1);
                              await listarVisitasRetro();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Borrar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: ()   {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenudeOpcionesListado()),
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
                                color: Color.fromARGB(255, 31, 55, 192),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )));
        });
  }


  void PadronesNoEncontrado() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeTitulo.formItemsDesign(
                          "Error al descargar Padrones"),
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





  void BorrarPercepcionesDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(Resources.iconInfo),
              SizedBox(width: 4), // Espacio entre el icono y el texto
              const Expanded(
                child: Text(
                  '¿Desea borrar el cuestionario descargado?',
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
                  onPressed: () async {
                    /*
                    CargaDialog(); //PANTALLA DE CARGA
                    try {
                      await widget.formDataModelDaoFormulario.BorrarTodo();
                    }  catch (error) {
                      print("Error erase FORMULARIO: $error");
                      _mostrarLoadingStreamController.add(true);
                      _mostrarLoadingStreamControllerTITUTLO.add("Error en el borrado");
                      _mostrarLoadingStreamControllerTEXTO.add("Ocurrio algun problema");
                    }
                    //TERMINO
                    _mostrarLoadingStreamController.add(true);
                    _mostrarLoadingStreamControllerTITUTLO.add("Se borro el Formulario");
                    _mostrarLoadingStreamControllerTEXTO.add("Puede descargar de nuevo");

 */
                    await widget.formDataModelDaoFormulario.BorrarTodo();
                    setState(() {
                      widget.dinamico = false;
                    });

                    Navigator.pop(context);
                    showDialogValidFields("Formulario Borrado, puede descargar otro");
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
  }

  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  final _mostrarLoadingStreamControllerTITUTLO = StreamController<String>.broadcast();
  final _mostrarLoadingStreamControllerTEXTO = StreamController<String>.broadcast();
  void CargaDialog() {
    bool mostrarLOADING = false;
    String texto1 = "Descargo Encuesta Percepciones";
    String texto2 = "Puede ingresar al formulario";
    showDialog(
      barrierDismissible: mostrarLOADING,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {

            _mostrarLoadingStreamController.stream.listen((value) {
              mostrarLOADING = value;
              setState(() {

              });
            });
            _mostrarLoadingStreamControllerTITUTLO.stream.listen((value) {
              texto1 = value;
              setState(() {

              });
            });
            _mostrarLoadingStreamControllerTEXTO.stream.listen((value) {
              texto2 = value;
              setState(() {

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

  //MODAL ANTES
  void GuardarPadronDialogAVISO(){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return StatefulBuilder(
              builder: (context, setState)
              {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  content: SingleChildScrollView(
                  child: Column(
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
                                  "Ya existen padrones",
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
                                child: Text ( "${widget.nombrePadron} Distrito: ${widget.departamentoPadron} " , style: const TextStyle(fontSize: 16),)
                            ),
                            const Icon(Icons.save, color: Colors.red,)
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

                              Navigator.pop(context);
                              GuardarPadronDialog();

                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Descargar de todas formas",
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
                    ],
                  )
                  )
                );});});
  }

  //MODAL
  void GuardarPadronDialog(){
    String MensajeSinc = "Descargando Padrones";
    String MensajeSubSinc = "El proceso borraria los padrones existentes anteriores, tambien tardara algunos minutos";
    bool mostrar = false;
    bool mostrarBoton = true;

    double progresso = 0.0;
    int progressoInicio = 0;
    int? progressoFin = 100;
    double sumando = 1;


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          //AGREGAR ESTO POR SI QUIERO QUE EL DIALOG SE REFRESQUE
          return StatefulBuilder(
              builder: (context, setState)
              {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    content: SingleChildScrollView(
                        child: Column(
                          children: [

                            //BARRA DE PROGRESO CON SU TITULO
                            HelpersViewAlertProgressSinc(
                                Mensaje: MensajeSinc,
                                subtexto: MensajeSubSinc,
                                progress: progresso,
                                mostrar: mostrar,
                                mostrarBoton: true,
                                contadorInicio: progressoInicio,
                                contadorFin: progressoFin
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Spacer(), // Push remaining space to the left

                                Visibility(
                                  visible: (!mostrarBoton),
                                  child: const Column(
                                    children: <Widget>[
                                      Text(
                                        ".",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),

                                Visibility(
                                  visible: (mostrarBoton),
                                  child: Column(
                                      children: <Widget>[


                                        InkWell(
                                          onTap: () async {

                                            //INICIALIZA CARGA
                                            setState(() {
                                              mostrar = true;
                                              MensajeSinc = "Conectando con la BD sea paciente, tardara unos minutos";
                                              mostrarBoton = false;
                                              MensajeSubSinc = "$progressoInicio/$progressoFin";
                                            });

                                            List<Padron> PadronEntity  = await widget.apiVersion.post_DescargarUsuarios();

                                            if(PadronEntity.length>0){
                                              setState(() {
                                                widget.total = PadronEntity.length;
                                                MensajeSinc = "Borrando Padrones anteriores";
                                                progressoFin = PadronEntity.length; //TOTAL PADRONES
                                                sumando = (100/PadronEntity.length!)/100;
                                              });
                                              //BORRAR TODA LA DATA EXISTENTE
                                              await widget.formDataModelDaoPadron.BorrarTodo();

                                              //AGREGAR AL QUE LO DESCARGO
                                              PadronLogin objPadron = PadronLogin();

                                              objPadron.id = 1;
                                              objPadron.nombre = PREFname;
                                              objPadron.apellidos = "$PREFapPaterno $PREFapMaterno";
                                              objPadron.hogarDepartamento = PREFdistrito; //ES DISTRITO PERO PUSE DEPA EN LA TABLA
                                              await widget.formDataModelDaoPadronLogin.insertFormDataModel(objPadron);
                                              //

                                              setState(() {
                                                MensajeSinc = "Descargando Padron";
                                              });

                                              for (int i = 0; i < PadronEntity.length; i++) {
                                                try {
                                                  await widget.formDataModelDaoPadron.insertFormDataModel(PadronEntity[i]);
                                                  print("AGREGADO PADRON ${i}");
                                                  //AUMENTAR LA BARRA
                                                  //AUMENTA
                                                  setState(() {
                                                    //mostrar = true;
                                                    //progresso = 0.0;
                                                    progresso += (sumando);
                                                    progressoInicio++;
                                                    MensajeSubSinc = "$progressoInicio/$progressoFin";
                                                  });

                                                }
                                                catch (error) { print("Error saving ONDICION CANTIADAD: $error"); }
                                              }
                                              //TERMINO
                                              loadTotalRegister();
                                              setState(() {
                                                widget.totalPadrones = PadronEntity.length;
                                              });


                                              Navigator.pop(
                                                  context); //Close your current dialog
                                              showDialogValidFields(
                                                  "Sincronización exitosa");

                                            } else { print("ALGO SALIO MAL");
                                            Navigator.pop(
                                                context);
                                            showDialogValidFields(
                                                "No se encontraron Padrones");
                                            }

                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, right: 20, bottom: 20),
                                            child: const Text(
                                              "Descargar",
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


                                      ]),),


                              ],
                            ),
                          ],
                        )
                    )
                );});});
  }

  Widget formUI() {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [

          //FORMULARIO ENCUESTA
          Row(
            children: [
               Expanded(
                flex: 5,
                child:           GestureDetector(
                    onTap: () async {

                      if(widget.backup){
                        await widget.formDataModelDaoBackup.BorrarTodo();
                      }

                      Widget ContactoRefererencia = MenudeOpcionesOffline(Respuesta()); //CARGO DATA
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ContactoRefererencia), //VOY AHI
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: const Text("Formulario de encuesta",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ))
              ),
              const Spacer(),
              Visibility(
                  visible: widget.backup,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                    IconButton(
                      icon: Image.asset(Resources.guardar),
                      color: Colors.white,
                      onPressed: () async {
                        //Convierto el backup en el objeto respuesta
                        Respuesta obj = BackupMapper.instance.backuptoResp(objBackup);
                        //MODIFICAR PARA QUE CARGE un backup con ID null
                        Widget ContactoRefererencia = MenudeOpcionesOffline(obj); //CARGO DATA
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ContactoRefererencia), //VOY AHI
                        );
                      },
                    ),
                  ),
              ),

              Visibility(
                visible: !widget.backup,
                child:
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:
                  IconButton(
                    icon: ColorFiltered(
                      colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation), // Apply grayscale filter
                      child: Image.asset(Resources.guardar),
                    ),
                    color: Colors.white, // This might not be necessary anymore due to the filter
                    onPressed: ()  {
                      showDialogValidFields(
                          "Este es el backup, sino termina una encuesta este boton le permitira retomarla.");
                    },
                  )
                ),
              ),
            ],
          ),

          //ENCUESTAS PERCEPCIONES EN DURO
          Row(
            children: [
              Expanded(
                  flex: 5,
                  child:  GestureDetector(
                      onTap: () async {

                        if(widget.backup){
                          await widget.formDataModelDaoBackup.BorrarTodo();
                        }

                        Widget ContactoRefererencia = MenudeOpcionesPercepcion(Respuesta()); //CARGO DATA
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ContactoRefererencia), //VOY AHI
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Color.fromARGB(255, 27, 65, 187),
                        ),
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: const Text("Encuesta Percepcion",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ))
              ),
              const Spacer(),
              Visibility(
                visible: widget.backup,
                child:
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:
                  IconButton(
                    icon: Image.asset(Resources.guardar),
                    color: Colors.white,
                    onPressed: () async {
                      //Convierto el backup en el objeto respuesta
                      Respuesta obj = BackupMapper.instance.backuptoResp(objBackup);
                      //MODIFICAR PARA QUE CARGE un backup con ID null
                      Widget ContactoRefererencia = MenudeOpcionesOffline(obj); //CARGO DATA
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ContactoRefererencia), //VOY AHI
                      );
                    },
                  ),
                ),
              ),

              Visibility(
                visible: !widget.backup,
                child:
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                    IconButton(
                      icon: ColorFiltered(
                        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation), // Apply grayscale filter
                        child: Image.asset(Resources.guardar),
                      ),
                      color: Colors.white, // This might not be necessary anymore due to the filter
                      onPressed: ()  {
                        showDialogValidFields(
                            "Este es el backup, sino termina una encuesta este boton le permitira retomarla.");
                      },
                    )
                ),
              ),
            ],
          ),

          //BOTON ENCUESTA PERCEPCIONES
          /*
          GestureDetector(
              onTap: () async {

                if(!widget.dinamico){
                  showDialogValidFields("Tiene que descargar la encuesta"); //LO ULTIMO QUE HIZE
                } else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenudeOpcionesDinamico(Respuesta())), //VOY AHI
                  );
                }


              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Color.fromARGB(255, 27, 65, 187),
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: const Text("Encuesta percepcion",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),
          */

          GestureDetector(
              onTap: () async {

                if(PREFtypeUser == "ADMIN") {

                  showDialogValidFields(
                      "Usted es Admin, no puede descargar");

                } else {
                  if(widget.nombrePadron == "") {
                    GuardarPadronDialog();
                  } else {
                    GuardarPadronDialogAVISO();
                  }
                }
                
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Color.fromARGB(255, 27, 65, 187),
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: const Text("Cargar padrón de usuarios",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),


          Container(
            margin: EdgeInsets.only(left: 20.0, top: MediaQuery.of(context).size.height * 0.020, bottom: MediaQuery.of(context).size.height * 0.020),
            alignment: Alignment.centerLeft,
            child: Text(
              "Total de Padrones: ${widget.totalPadrones}",
              textAlign: TextAlign.left,
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 20.0, top: MediaQuery.of(context).size.height * 0.020, bottom: MediaQuery.of(context).size.height * 0.020),
            alignment: Alignment.centerLeft,
            child: Text(
              "Total de Respuestas: ${widget.total}",
              textAlign: TextAlign.left,
            ),
          ),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // Center horizontally
              children: [
                GestureDetector(
                  onTap: () async {
                    await listarVisitasRetro();
                  },
                  child: Image.asset(Resources.inconflechaD, width: 48, height: 48),
                ),


                Text(
                  "${widget.page}/${widget.totalPage}", //DEBO PONER EL TOTAL ENTRE 1
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () async {
                    await listarVisitasAvanzar();
                  },
                  child: Image.asset(Resources.inconflechaI, width: 48, height: 48),
                )

                // Add Textfield with appropriate margin
              ],
            ),
          ),


          SizedBox(
              //width: double.maxFinite,
              width: 400.0,
              height: 300.0,
              child: widget.listRespuesta.isNotEmpty
                  ? ListView.builder(itemCount: widget.listRespuesta!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        ModificarBorrar(index, widget.listRespuesta![index]);
                      },
                      child: ListTile(
                        title: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.040,
                          child: Text(
                            "${index + 1})",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DNI GESTOR: ${widget.listRespuesta![index].id_gestor}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.010,
                            ),
                            Text(
                              "Puntaje: ${widget.listRespuesta![index].puntaje}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.010,
                            ),
                            Text(
                              "Fecha: ${widget.listRespuesta![index].fecha}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },)
                  : const Text('Aún no hay data para mostrar')
          ),


          //EXPANDED ANIMATION INFINITE SCOLLVIEW
          /*
          SizedBox(
            width: double.infinity, // Fills available space horizontally
            height: 350, // Set your desired height
            child: AnimatedInfiniteScrollView<Respuesta>(
              viewModel: widget.viewModel,
              itemBuilder: (context, index, item) {

                return Column(
                  children: [

                  ],
                );

              },
              refreshIndicator: true,
            ),
          ), */



        ],),
    );
  }
}
