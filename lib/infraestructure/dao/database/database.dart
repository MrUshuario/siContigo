import 'dart:async';
import 'package:sicontigo/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:sicontigo/infraestructure/dao/formdatamodeldao_html.dart';
import 'package:sicontigo/infraestructure/dao/formdatamodeldao_visita.dart';
import 'package:sicontigo/model/t_html.dart';
import 'package:sicontigo/model/t_respuesta.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import '../../../model/t_formulario.dart';
import '../formdatamodeldao_respuesta.dart';
part 'database.g.dart';


@Database(version: 1, entities:
[ Html, Formulario, Respuesta ])

abstract class AppDatabase extends FloorDatabase {
  //FormDataModelDaoVISITA get formDataModelDaoVisita;
  FormDataModelDaoHTML get  formDataModelDaoHTML;
  FormDataModelDaoFormulario get  formDataModelDaoFormulario;
  FormDataModelDaoRespuesta get  formDataModelDaoRespuesta;

}