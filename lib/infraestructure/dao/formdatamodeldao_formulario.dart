import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';

import 'package:floor/floor.dart';

@dao
abstract class FormDataModelDaoFormulario {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Formulario formDataModel);

  @Query('SELECT * FROM Formulario LIMIT :perPage OFFSET :offset')
  Future<List<Formulario>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Formulario')
  Future<List<Formulario>> findAllFormulario();

  @Query('SELECT cod FROM Formulario WHERE cod = :cod')
  Future<String?> findAllFormularioID(int cod);

  @Query('SELECT COUNT(*) FROM Formulario')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM Html WHERE cod = :cod')
  Future<int?> BorrarFormDataModels(int cod);

  @Query('DELETE FROM Formulario')
  Future<int?> BorrarTodo();

}