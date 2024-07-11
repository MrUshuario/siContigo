import 'dart:async';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUPpercepcion.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUPunovisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_visita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuestaEnvioGenerico.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import '../../../model/t_padronlogin.dart';
import '../../../model/t_formulario.dart';
import '../../../model/t_padron.dart';
import '../../../model/visitaDomiciliaria/t_respBackuppercepciones.dart';
import '../../../model/visitaDomiciliaria/t_respBackupprimeravisita.dart';
import '../../../model/visitaDomiciliaria/t_respBackupsegundavisita.dart';
import '../../../model/visitaDomiciliaria/t_respBackupterceravisita.dart';
import '../formdatamodeldao_padron.dart';
import '../formdatamodeldao_padronLogin.dart';
import '../formdatamodeldao_respuestaBACKUPdosvisita.dart';
import '../formdatamodeldao_respuestaBACKUPtresvisita.dart';
import '../formdatamodeldao_respuestaunovisita.dart';
part 'database.g.dart';


@Database(version: 1, entities:
[Formulario, RespuestaPrimeraVisita, RespuestaENVIO, RespuestaBACKUPprimeravisita,
  RespuestaBACKUPsegundavisita, RespuestaBACKUPterceravisita, Padron,
  PadronLogin, RespuestaBACKUPpercepcion ])

abstract class AppDatabase extends FloorDatabase {
  FormDataModelDaoFormulario get  formDataModelDaoFormulario;
  FormDataModelDaoRespuestaunovisita get  formDataModelDaoRespuesta;
  FormDataModelDaoRespuestaBACKUPunovisita get formDataModelDaoRespuestaBACKUP;
  FormDataModelDaoRespuestaBACKUPdosvisita get formDataModelDaoRespuestaBACKUPdosvisita;
  FormDataModelDaoRespuestaBACKUPtresvisita get formDataModelDaoRespuestaBACKUPtresvisita;
  FormDataModelDaoRespuestaBACKUpercepcion get formDataModelDaoRespuestaBACKUpercepcion;
  FormDataModelDaoPadron get formDataModelDaoPadron;
  FormDataModelDaoPadronLogin get formDataModelDaoPadronLogin;

}