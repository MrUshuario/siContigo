
import 'package:floor/floor.dart';
import '../../model/visitaDomiciliaria/t_respBackupsegundavisita.dart';

@dao
abstract class FormDataModelDaoRespuestaBACKUPdosvisita {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(RespuestaBACKUPsegundavisita formDataModel);

  @Query('SELECT * FROM RespuestaBACKUPsegundavisita')
  Future<List<RespuestaBACKUPsegundavisita>> findAllRespuesta();

  @Query('SELECT COUNT(*) FROM RespuestaBACKUPsegundavisita')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM RespuestaBACKUPsegundavisita')
  Future<int?> BorrarTodo();

}