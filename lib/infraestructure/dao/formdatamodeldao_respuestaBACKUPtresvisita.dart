
import 'package:floor/floor.dart';
import '../../model/visitaDomiciliaria/t_respBackupterceravisita.dart';

@dao
abstract class FormDataModelDaoRespuestaBACKUPtresvisita {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(RespuestaBACKUPterceravisita formDataModel);

  @Query('SELECT * FROM RespuestaBACKUPterceravisita')
  Future<List<RespuestaBACKUPterceravisita>> findAllRespuesta();

  @Query('SELECT COUNT(*) FROM RespuestaBACKUPterceravisita')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM RespuestaBACKUPterceravisita')
  Future<int?> BorrarTodo();

}