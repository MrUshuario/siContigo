
import 'package:floor/floor.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';

import '../../model/visitaDomiciliaria/t_respBackupprimeravisita.dart';

@dao
abstract class FormDataModelDaoRespuestaBACKUPunovisita {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(RespuestaBACKUPprimeravisita formDataModel);

  @Query('SELECT * FROM RespuestaBACKUPprimeravisita')
  Future<List<RespuestaBACKUPprimeravisita>> findAllRespuesta();

  @Query('SELECT COUNT(*) FROM RespuestaBACKUPprimeravisita')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM RespuestaBACKUPprimeravisita')
  Future<int?> BorrarTodo();

}