import 'dart:async';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/database/database.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/constantes.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_login.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/viewmodels/form_viewsmodel_formulario.dart';

import '../../utils/helpersviewBlancoIcon.dart';


class MenudeOpciones extends StatefulWidget {
  final viewModel = FormDataModelViewModel();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  apiprovider_formulario apiForm = apiprovider_formulario();
  FormDataModelDaoFormulario get formDataModelDaoFormulario => _appDatabase.formDataModelDaoFormulario;
  List<Formulario> listForm = List.empty(growable: true);
  MenudeOpciones({Key? key});
  int? total = 0;

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpciones();
  }

}

enum EstadoFallecido { Si, No } //SOLO SIRVE PARA MOSTRAR NO SE GUARDA

class _MenudeOpciones extends State<MenudeOpciones> {

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
    var res = await widget.formDataModelDaoFormulario.totalFormDataModels();
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
                                builder: (context) => MenudeOpciones()),
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
                      }  catch (error) { print("Error saving FORMULARIO: $error"); }
                    }
                    //TERMINO
                    showDialogValidFields("Sincronización exitosa");
                    //
                    widget.viewModel
                      ..listen()
                      ..getPaginationList();

                  } else {
                    print("ALGO SALIO MAL");
                    showDialogValidFields("No se encontraron Padrones");
                  }

                }

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
                child: const Text("Descargar Formulario",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),


          GestureDetector(
              onTap: () async {

                await loadTotalRegister();
                await listarVisitasRetro();
              
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
                child: const Text("Cargar Formulario",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              )),

          Container(
            margin: EdgeInsets.only(left: 20.0, top: MediaQuery.of(context).size.height * 0.020, bottom: MediaQuery.of(context).size.height * 0.020),
            alignment: Alignment.centerLeft,
            child: Text(
              "Total de Formularios: ${widget.total}",
              textAlign: TextAlign.left,
            ),
          ),


          /* // ESTE EXPANDED ES EL PAGINADO
          Expanded(
              child: widget.listForm.isNotEmpty
                  ? ListView.builder(itemCount: widget.listForm!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        //ModificarBorrar(index, widget.listForm![index]);
                      },
                      child: ListTile(
                        title: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.040,
                          child: Text(
                            "${index + 1}",
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
                              "Pregunta: ${widget.listForm![index].pregunta}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.040,
                            ),
                            Text(
                              "Tipo Opcion: ${widget.listForm![index].tipoOpcion}",
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
          ), List<String> lista = [item.tipoOpcion];*/

          //EXPANDED ANIMATION INFINITE SCOLLVIEW
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
                    // Other properties for the TextFormField
                  ),
                  context,
                ),
                ),



                    //OPCIONES
                    Visibility(
                      visible: !MostrarInput,
                        child:
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: tipoOpcionList?.length ?? 0,
                            itemBuilder: (context, index) {

                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red, // Change this to your desired color
                                    width: 1.0, // Adjust border width here
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

                                    const SizedBox(width: 01.0), // Add spacing between text and radio
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

                                    /*
                                Padding(
                                  padding: EdgeInsets.only(left: 0.0),
                                  child:

                                  ),
                                ),
                                */

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

                /*
                return Card(
                  child: InkWell(
                    onTap: () {
                      //ModificarBorrar(index, item); // You can now use 'item'
                    },
                    child: ListTile(
                      title: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.040,
                        child: Text(
                          "${index + 1}",
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
                            "Pregunta: ${item.pregunta}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.040,
                          ),
                          Text(
                            "Tipo respuesta: ${item.tipoRepuesta}",
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
                */


              },
              refreshIndicator: true,
            ),
          ),

        ],),
    );
  }
}
