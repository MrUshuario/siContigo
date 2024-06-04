

import 'package:floor/floor.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_padron.dart';

@dao
abstract class FormDataModelDaoPadron {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormDataModel(Padron formDataModel);

  @Query('SELECT * FROM Padron')
  Future<List<Padron>> findAllPadron();

  @Query('SELECT * FROM Padron WHERE dniCe = :id')
  Future<List<Padron>> findAllPadronDNI(String id);

  @Query('SELECT COUNT(*) FROM Padron')
  Future<int?> totalFormDataModels();

  @Query('DELETE FROM Html WHERE cod = :cod')
  Future<int?> BorrarFormDataModels(int cod);

  @Query('DELETE FROM Padron')
  Future<int?> BorrarTodo();

}