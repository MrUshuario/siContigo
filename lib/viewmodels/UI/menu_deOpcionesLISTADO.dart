import 'dart:async';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
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
import 'package:sicontigo/viewmodels/UI/viewmodels/form_viewsmodel_respuesta.dart';


import '../../utils/helpersviewBlancoIcon.dart';


class MenudeOpcionesListado extends StatefulWidget {
  final viewModel = FormDataModelViewModel();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  apiprovider_formulario apiForm = apiprovider_formulario();
  FormDataModelDaoRespuesta get formDataModelDaoRespuesta => _appDatabase.formDataModelDaoRespuesta;
  List<Formulario> listForm = List.empty(growable: true);
  MenudeOpcionesListado({Key? key});
  int? total = 0;

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesListado();
  }

}

enum EstadoFallecido { Si, No } //SOLO SIRVE PARA MOSTRAR NO SE GUARDA

class _MenudeOpcionesListado extends State<MenudeOpcionesListado> {

  late String PREFname;
  late String PREFapPaterno;
  late String PREFapMaterno;
  late String PREFnroDoc;
  late String PREFtypeUser;
  late String PREFtoken;

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

  @override
  void initState() {
    conseguirVersion();
    widget.viewModel
    ..listen()
    ..getPaginationList();
    loadTotalRegister();
    // TODO: implement initState
    super.initState();
  }

  EstadoFallecido? _EstadoFallecido = null;

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

  Future<void> listarVisitasRetro() async {
    widget.viewModel
      ..listen()
      ..getPaginationList();
    /*
    var pages = widget.page!-1;
    if(pages > 0) {
      widget.page = pages;
    }
    var offset = (widget.page!*10)-10;
    if(offset < 0) {
      offset = 0;
    }*/
    //widget.listVisitas = await widget.formDataModelDaoFormulario.findFormDataModel(offset, 10);
    //widget.totalPage = calcularTotalPaginas(widget.total!, 10);
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

  Widget formUI() {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [

          GestureDetector(
              onTap: () async {

                // NUEVO FORM
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
                child: const Text("Crear nuevo formulario",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),


          Container(
            margin: EdgeInsets.only(left: 20.0, top: MediaQuery.of(context).size.height * 0.020, bottom: MediaQuery.of(context).size.height * 0.020),
            alignment: Alignment.centerLeft,
            child: Text(
              "Total de Respuestas: ${widget.total}",
              textAlign: TextAlign.left,
            ),
          ),


          //EXPANDED ANIMATION INFINITE SCOLLVIEW
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
          ),

        ],),
    );
  }
}
