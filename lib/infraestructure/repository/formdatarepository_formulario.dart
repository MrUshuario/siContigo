
import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:sicontigoVisita/infraestructure/dao/formdatamodeldao_formulario.dart';
import '../../model/t_formulario.dart';
import '../dao/database/database.dart';
import '../dao/formdatamodeldao_visita.dart';

class FormDataRepository {

  final _controller = StreamController<PaginationState<List<Formulario>>>();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoFormulario get formDataModelDaoForm => _appDatabase.formDataModelDaoFormulario;

  Stream<PaginationState<List<Formulario>>> get result async* {
    yield* _controller.stream;
  }

  Future<int> getPassengersList(int page) async {
    _controller.add(const PaginationLoading());

    try {
      final offset = (10 * page) - 10;
      List<Formulario> responses = await formDataModelDaoForm.findFormDataModel(offset, 10);
      int? total = await formDataModelDaoForm.totalFormDataModels();
      /// emit fetched data
      _controller.add(PaginationSuccess(responses));
      return total ?? 0;
    } catch (_) {
      /// emit error
      _controller.add(const PaginationError());
      return 0;
    }
  }

}