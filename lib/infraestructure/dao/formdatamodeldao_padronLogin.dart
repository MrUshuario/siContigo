import 'package:Sicontigo_Visita_Domiciliaria/model/t_padronlogin.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormDataModelDaoPadronLogin {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(PadronLogin formDataModel);

  @Query('SELECT * FROM PadronLogin LIMIT :perPage OFFSET :offset')
  Future<List<PadronLogin>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM PadronLogin')
  Future<List<PadronLogin>> findAllPadronLogin();

  @Query('SELECT PadronLogincodigo FROM PadronLogin WHERE id = :id')
  Future<String?> findAllPadronLoginID(int id);

  @Query('SELECT COUNT(*) FROM PadronLogin')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM PadronLogin WHERE codigoVisita = :ID')
  Future<int?> BorrarFormDataModels(int ID);

}