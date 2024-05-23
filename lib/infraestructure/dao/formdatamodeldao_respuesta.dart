import 'package:sicontigo/model/t_respuesta.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormDataModelDaoRespuesta {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Respuesta formDataModel);

  @Query('SELECT * FROM Respuesta LIMIT :perPage OFFSET :offset')
  Future<List<Respuesta>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Respuesta')
  Future<List<Respuesta>> findAllRespuesta();

  @Query('SELECT Respuestacodigo FROM Respuesta WHERE cod = :cod')
  Future<String?> findAllRespuestaID(int cod);

  @Query('SELECT COUNT(*) FROM Respuesta')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM Respuesta WHERE cod = :cod')
  Future<int?> BorrarFormDataModels(int cod);

  @Query('DELETE FROM Respuesta')
  Future<int?> BorrarTodo();

}