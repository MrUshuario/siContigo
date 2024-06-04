import 'dart:async';
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
  FormDataModelDaoRespuestaBACKUP get formDataModelDaoBackup => _appDatabase.formDataModelDaoRespuestaBACKUP;
  List<Formulario> listForm = List.empty(growable: true);
  MenudeOpcionesListado({Key? key});

  int? totalPadrones = 0;

  int? total = 0;
  int? page = 1;
  int? totalPage = 0;
  List<Respuesta> listRespuesta = List.empty(growable: true);


  apiprovider_menuOpciones apiVersion = apiprovider_menuOpciones();
  //BACKUP
  bool backup = false;

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
      PREFname = prefs.getString('name') ?? "ERROR";
      PREFapPaterno = prefs.getString('apPaterno') ?? "ERROR";
      PREFapMaterno = prefs.getString('apMaterno') ?? "ERROR";
      PREFnroDoc = prefs.getString('nroDoc') ?? "ERROR";
      PREFtypeUser = prefs.getString('typeUser') ?? "ERROR";
      PREFtoken = prefs.getString('token') ?? "ERROR";
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



  @override
  void initState() {
    revisarBackup();
    conseguirVersion();
    widget.viewModel
    ..listen()
    ..getPaginationList();
    loadTotalRegister();
    loadTotalPadrones();
    listarVisitasRetro();
    // TODO: implement initState
    super.initState();
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

  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  final _mostrarLoadingStreamControllerTEXTO = StreamController<String>.broadcast();
  void CargaDialog() {
    bool mostrarLOADING = false;
    String texto1 = "Termino la descarga";
    String texto2 = "Hubo un error";
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
            _mostrarLoadingStreamControllerTEXTO.stream.listen((value) {
              setState(() {
                texto2 = value;
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

                                            ////
                                            /*
                                            if(PadronEntity.length>0){
                                              //BORRAR TODA LA DATA EXISTENTE
                                              await widget.formDataModelDaoPadron.BorrarTodo();
                                              for (int i = 0; i < PadronEntity.length; i++) {
                                                try { await widget.formDataModelDaoPadron.insertFormDataModel(PadronEntity[i]);
                                                } catch (error) { print("Error saving TIPO DISCAPACIDAD : $error");
                                                _mostrarLoadingStreamController.add(true);
                                                }
                                              }


                                              String texto = "Total de Padrones: ${PadronEntity.length}";

                                              setState(() {
                                                widget.totalPadrones = PadronEntity.length;
                                              });

                                              _mostrarLoadingStreamController.add(true);
                                              _mostrarLoadingStreamControllerTEXTO.add(texto);

                                            } else {
                                              print("ALGO SALIO MAL");
                                              _mostrarLoadingStreamController.add(true);
                                            } */

                                            ////

                                            if(PadronEntity.length>0){
                                              setState(() {
                                                widget.total = PadronEntity.length;
                                                MensajeSinc = "Borrando Padrones anteriores";
                                                progressoFin = PadronEntity.length; //TOTAL PADRONES
                                                sumando = (100/PadronEntity.length!)/100;
                                              });
                                              //BORRAR TODA LA DATA EXISTENTE
                                              await widget.formDataModelDaoPadron.BorrarTodo();
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
                    ));});});
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
            visible: widget.backup,
            child:Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {

                      //Convierto el backup en el objeto respuesta
                      Respuesta obj = BackupMapper.instance.backuptoResp(objBackup);
                      //MODIFICAR PARA QUE CARGE un backup con ID null
                      Widget ContactoRefererencia = MenudeOpcionesOffline(obj); //CARGO DATA
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
                      child: const Text("Continuar Formulario\n incompleto",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),

              ],),
          ),

  /*
  GestureDetector(
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
                child: const Text("Modernización del pago",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),
*/
          GestureDetector(
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
              )),

          GestureDetector(
              onTap: () async {

                //CargaDialog();
                GuardarPadronDialog();
                
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
