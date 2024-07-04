import 'dart:async';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_html.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUPunovisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_visita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_html.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuestaprimeravisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuestaEnvioGenerico.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import '../../../model/t_padronlogin.dart';
import '../../../model/t_formulario.dart';
import '../../../model/t_padron.dart';
import '../../../model/t_respBackupprimeravisita.dart';
import '../formdatamodeldao_padron.dart';
import '../formdatamodeldao_padronLogin.dart';
import '../formdatamodeldao_respuestaunovisita.dart';
part 'database.g.dart';


@Database(version: 1, entities:
[ Html, Formulario, RespuestaPrimeraVisita, RespuestaENVIO, RespuestaBACKUPprimeravisita, Padron, PadronLogin ])

abstract class AppDatabase extends FloorDatabase {
  //FormDataModelDaoVISITA get formDataModelDaoVisita;
  FormDataModelDaoHTML get  formDataModelDaoHTML;
  FormDataModelDaoFormulario get  formDataModelDaoFormulario;
  FormDataModelDaoRespuestaunovisita get  formDataModelDaoRespuesta;
  FormDataModelDaoRespuestaBACKUPunovisita get formDataModelDaoRespuestaBACKUP;
  FormDataModelDaoPadron get formDataModelDaoPadron;
  FormDataModelDaoPadronLogin get formDataModelDaoPadronLogin;

}