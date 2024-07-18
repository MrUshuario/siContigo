import 'dart:convert';
import 'dart:io';

import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpcionesPERCEPCION.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_deOpcionesVisitaTres.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/resources.dart';
import '../../viewmodels/UI/menu_deOpcionesVisitaDos.dart';
import '../../viewmodels/UI/menu_deOpcionesVisitaUno.dart';
import '../../viewmodels/UI/menu_login.dart';
import '../visitaDomiciliaria/t_respuestaprimeravisita.dart';

class DisplayPhoto extends StatefulWidget {

  RespuestaPrimeraVisita? formDataModel;
  int? indexPhotos;

  /// Default Constructor
  DisplayPhoto(this.formDataModel, this.indexPhotos, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DisplayPhoto();
  }
}

class _DisplayPhoto extends State<DisplayPhoto> {

  XFile? videoFile;
  VideoPlayerController? videoController;
   // = this.formDataModel.fotoUno;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text("Ver Foto", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFD60000),
        actions: [
          IconButton(
            icon: Image.asset(Resources.flechaazul),
            color: Colors.white,
            onPressed: () {

              var codigoForm =  widget.formDataModel?.tipoencuesta ;
              switch (codigoForm) {

                case Resources.valor_primeraVisita:

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenudeOpcionesVisitaUno(widget.formDataModel)),
                  );

                case Resources.valor_segundaVisita:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenudeOpcionesVisitaDos(widget.formDataModel)),
                  );

                case Resources.valor_terceraVisita:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenudeOpcionesVisitaTres(widget.formDataModel)),
                  );

                case Resources.valor_percepciones:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MenudeOpcionesPercepcion(widget.formDataModel)),
                  );

                default:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  login()),
                  );
              }

            },
          ),
        ],
      ),
      body: _thumbnailWidget(),);
  }

  String? getPhoto() {
    var listPhotos = List.empty(growable: true);
    listPhotos.add("");
    listPhotos.add("");
    listPhotos.add("");
    listPhotos.add("");
    if(widget.formDataModel!.fotoUno!=null && widget.formDataModel!.fotoUno!.isNotEmpty) {
      listPhotos[0] = widget.formDataModel!.fotoUno;
    }
    if(widget.formDataModel!.fotoDos!=null && widget.formDataModel!.fotoDos!.isNotEmpty) {
      listPhotos[1] = widget.formDataModel!.fotoDos;
    }
    if(widget.formDataModel!.fotoTres!=null && widget.formDataModel!.fotoTres!.isNotEmpty) {
      listPhotos[2] = widget.formDataModel!.fotoTres;
    }
    if(widget.formDataModel!.fotoCuatro!=null && widget.formDataModel!.fotoCuatro!.isNotEmpty) {
      listPhotos[3] = widget.formDataModel!.fotoCuatro;
    }
    if(widget.formDataModel!.fotoUno == listPhotos[widget.indexPhotos!]) {
      return widget.formDataModel!.fotoUno;
    } else if(widget.formDataModel!.fotoDos == listPhotos[widget.indexPhotos!]) {
      return widget.formDataModel!.fotoDos;
    } else if(widget.formDataModel!.fotoTres == listPhotos[widget.indexPhotos!]) {
      return widget.formDataModel!.fotoTres;
    } else if(widget.formDataModel!.fotoCuatro == listPhotos[widget.indexPhotos!]) {
      return widget.formDataModel!.fotoCuatro;
    } else {
      return "";
    }
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    final VideoPlayerController? localVideoController = videoController;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        if (localVideoController == null && getPhoto()!.isEmpty)
          Container()
        else
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: (localVideoController == null)
                ? (
                // The captured image on the web contains a network-accessible URL
                // pointing to a location within the browser. It may be displayed
                // either with Image.network or Image.memory after loading the image
                // bytes to memory.
                kIsWeb
                    ? Image.memory(base64Decode(getPhoto()!))
                    : Image.memory(base64Decode(getPhoto()!)))
                : Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink)),
              child: Center(
                child: AspectRatio(
                    aspectRatio:
                    localVideoController.value.aspectRatio,
                    child: VideoPlayer(localVideoController)),
              ),
            ),
          ),
      ],
    );
  }

}