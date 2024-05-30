import 'package:sicontigoVisita/model/t_html.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormDataModelDaoHTML {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Html formDataModel);

  @Query('SELECT * FROM Html LIMIT :perPage OFFSET :offset')
  Future<List<Html>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Html')
  Future<List<Html>> findAllHtml();

  @Query('SELECT htmlcodigo FROM Html WHERE id = :id')
  Future<String?> findAllHtmlID(int id);

  @Query('SELECT COUNT(*) FROM Html')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM Html WHERE codigoVisita = :ID')
  Future<int?> BorrarFormDataModels(int ID);

}