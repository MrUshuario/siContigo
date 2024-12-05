import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';

import 'package:floor/floor.dart';

@dao
abstract class FormDataModelDaoFormulario {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Formulario formDataModel);

  @Query('SELECT * FROM Formulario')
  Future<List<Formulario>> findFormDataModelORIGINAL();

  @Query('SELECT * FROM Formulario LIMIT :perPage OFFSET :offset')
  Future<List<Formulario>> findFormDataModel(int offset, int perPage);

  @Query('SELECT * FROM Formulario')
  Future<List<Formulario>> findAllFormulario();

  @Query('SELECT cod FROM Formulario WHERE cod = :cod')
  Future<String?> findAllFormularioID(int cod);

  @Query('SELECT COUNT(*) FROM Formulario')
  Future<int?> totalFormDataModels();

  //SEPARAR PREGUNTAS POR TIPOS
  @Query('SELECT COUNT(*) FROM Formulario WHERE tipoRepuesta = 2')
  Future<int?> totalFormDataModelsCIRCLE();

  @Query('SELECT COUNT(*) FROM Formulario WHERE tipoRepuesta = 4')
  Future<int?> totalFormDataModelsCHECKS();
  //ESTE ES UN CASO ESPECIAL REQUIERE EL NUMERO DE CHECKS
  @Query('SELECT * FROM Formulario WHERE tipoRepuesta = 4')
  Future<List<Formulario>> findAllFormularioCHECK();
  //@Query('SELECT formulario_id, puntaje, COUNT(regexp_matches(puntaje, "[^;]+")) AS num_puntajes FROM Formulario')
  //Future<int?> totalFormDataModelsCHECKSconteo();


  @Query('SELECT COUNT(*) FROM Formulario WHERE tipoRepuesta = 1')
  Future<int?> totalFormDataModelsINPUT();

  //SEGUN LA SECCION
  @Query('SELECT COUNT(*) FROM Formulario WHERE id_seccion = :id')
  Future<int?> totalFormDataModelsSECCION(int id);

  @Query('SELECT * FROM Formulario WHERE id_seccion = :id  LIMIT :perPage OFFSET :offset')
  Future<List<Formulario>> findFormDataModelSECCION(int offset, int perPage, int id);
  ////

  @Query('DELETE FROM Html WHERE cod = :cod')
  Future<int?> BorrarFormDataModels(int cod);

  @Query('DELETE FROM Formulario')
  Future<int?> BorrarTodo();

}