

import 'package:sicontigoVisita/model/t_respuesta.dart';
import 'package:sicontigoVisita/model/t_respuestaBACKUP.dart';

class RespuestaMapper {

  RespuestaMapper._();
  static RespuestaMapper get instance => RespuestaMapper._();

  int? idformato;
  int? id_usuario;
  String? fecha;
  String? respuestas;
  String? longitud;
  String? latitud;
   int? id_gestor;

  RespuestaENVIO visitaToVisitaApi(Respuesta rpta) {
    var rptaApi = RespuestaENVIO();
    rptaApi.idformato = rpta.idformato;
    rptaApi.id_usuario = rpta.id_usuario;
    rptaApi.fecha = rpta.fecha;
    rptaApi.respuestas = rpta.respuestas;
    rptaApi.longitud = rpta.longitud;
    rptaApi.latitud = rpta.latitud;
    rptaApi.id_gestor= rpta.id_gestor;

    return rptaApi;
  }

  List<RespuestaENVIO> listRespuestaToRespuestaENVIO(List<Respuesta> listVisitas) {
    return listVisitas.map((e) => visitaToVisitaApi(e)).toList();
  }
}