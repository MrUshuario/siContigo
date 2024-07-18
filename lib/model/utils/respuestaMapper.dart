

import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuestaEnvioGenerico.dart';

class RespuestaMapper {

  RespuestaMapper._();
  static RespuestaMapper get instance => RespuestaMapper._();



  RespuestaENVIO visitaToVisitaApi(RespuestaPrimeraVisita rpta) {
    var rptaApi = RespuestaENVIO();
    rptaApi.idformato = rpta.idformato;
    rptaApi.id_usuario = rpta.id_usuario;
    rptaApi.fecha = rpta.fecha;
    rptaApi.puntaje = rpta.puntaje;
    rptaApi.respuestas = rpta.respuestas;
    rptaApi.longitud = rpta.longitud;
    rptaApi.latitud = rpta.latitud;
    rptaApi.id_gestor= rpta.id_gestor;
    rptaApi.fecha_hora_inicio= rpta.fecha_hora_inicio;
    rptaApi.fecha_hora_fin= rpta.fecha_hora_fin;

    return rptaApi;
  }

  List<RespuestaENVIO> listRespuestaToRespuestaENVIO(List<RespuestaPrimeraVisita> listVisitas) {
    return listVisitas.map((e) => visitaToVisitaApi(e)).toList();
  }
}