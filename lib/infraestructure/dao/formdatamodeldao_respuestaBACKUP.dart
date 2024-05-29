
import 'package:floor/floor.dart';
import 'package:sicontigo/model/t_respBackup.dart';

@dao
abstract class FormDataModelDaoRespuestaBACKUP {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(RespuestaBACKUP formDataModel);

  @Query('SELECT * FROM RespuestaBACKUP')
  Future<List<RespuestaBACKUP>> findAllRespuesta();

  @Query('SELECT COUNT(*) FROM RespuestaBACKUP')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM RespuestaBACKUP')
  Future<int?> BorrarTodo();

}