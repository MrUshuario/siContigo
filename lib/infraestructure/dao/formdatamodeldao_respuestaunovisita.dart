import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuestaprimeravisita.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormDataModelDaoRespuestaunovisita {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(RespuestaPrimeraVisita formDataModel);

  @Query('SELECT * FROM RespuestaPrimeraVisita LIMIT :perPage OFFSET :offset')
  Future<List<RespuestaPrimeraVisita>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM RespuestaPrimeraVisita')
  Future<List<RespuestaPrimeraVisita>> findAllRespuesta();

  @Query('SELECT Respuestacodigo FROM RespuestaPrimeraVisita WHERE cod = :cod')
  Future<String?> findAllRespuestaID(int cod);

  @Query('SELECT COUNT(*) FROM RespuestaPrimeraVisita')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM RespuestaPrimeraVisita WHERE cod = :cod')
  Future<int?> BorrarFormDataModels(int cod);

  @Query('DELETE FROM RespuestaPrimeraVisita')
  Future<int?> BorrarTodo();

}