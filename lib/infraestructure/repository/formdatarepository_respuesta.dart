
import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:get_it/get_it.dart';
import 'package:sicontigoVisita/infraestructure/dao/formdatamodeldao_respuesta.dart';
import 'package:sicontigoVisita/model/t_respuesta.dart';
import '../dao/database/database.dart';


class FormDataRepository {

    //StreamController<PaginationState<List<Respuesta>>> _controller23 = StreamController<PaginationState<List<Respuesta>>>.broadcast();

  final _controller = StreamController<PaginationState<List<Respuesta>>>();
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuesta get formDataModelDaoForm => _appDatabase.formDataModelDaoRespuesta;

  Stream<PaginationState<List<Respuesta>>> get result async* {
    yield* _controller.stream;
  }

  Future<int> getPassengersList(int page) async {
    _controller.add(const PaginationLoading());

    try {
      final offset = (10 * page) - 10;
      List<Respuesta> responses = await formDataModelDaoForm.findFormDataModel(offset, 10);
      int? total = await formDataModelDaoForm.totalFormDataModels();
      /// emit fetched data
      _controller.add(PaginationSuccess(responses));
      return total ?? 0;
    } catch (_) {
      /// emit error
      _controller.add(const PaginationError());
      return 0;
    } finally{
       print("DISPO");
        _controller.close();
    }

  }

}