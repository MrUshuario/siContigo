
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respBackuppercepciones.dart';
import 'package:floor/floor.dart';

import '../../model/visitaDomiciliaria/t_respBackupprimeravisita.dart';

@dao
abstract class FormDataModelDaoRespuestaBACKUpercepcion {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(RespuestaBACKUPpercepcion formDataModel);

  @Query('SELECT * FROM RespuestaBACKUPpercepcion')
  Future<List<RespuestaBACKUPpercepcion>> findAllRespuesta();

  @Query('SELECT COUNT(*) FROM RespuestaBACKUPpercepcion')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM RespuestaBACKUPpercepcion')
  Future<int?> BorrarTodo();

}