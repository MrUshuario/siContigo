

import 'package:sicontigo/model/t_respuesta.dart';
import 'package:sicontigo/model/t_respuestaBACKUP.dart';

class VisitasMapper {

  VisitasMapper._();
  static VisitasMapper get instance => VisitasMapper._();

  int? idformato;
  int? id_usuario;
  String? fecha;
  String? respuestas;
  String? longitud;
  String? latitud;

  RespuestaENVIO visitaToVisitaApi(Respuesta rpta) {
    var rptaApi = RespuestaENVIO();
    rptaApi.idformato = rpta.idformato;
    rptaApi.id_usuario = rpta.id_usuario;
    rptaApi.respuestas = rpta.respuestas;
    rptaApi.longitud = rpta.longitud;
    rptaApi.latitud = rpta.latitud;
    return rptaApi;
  }

  List<RespuestaENVIO> listRespuestaToRespuestaENVIO(List<Respuesta> listVisitas) {
    return listVisitas.map((e) => visitaToVisitaApi(e)).toList();
  }
}