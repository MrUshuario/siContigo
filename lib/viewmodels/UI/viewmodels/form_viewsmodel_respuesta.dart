import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:sicontigo/model/t_respuesta.dart';

import '../../../infraestructure/repository/formdatarepository_respuesta.dart';
import '../../../model/t_visita.dart';

class FormDataModelViewModel with PaginationViewModel<Respuesta> {

  final repository = FormDataRepository();

  @override
  Function(Respuesta  a, Respuesta  b) compare = ((a, b) => a.cod.toString().compareTo(b.cod.toString()));

  @override
  bool  sortItems = false;

  @override
  bool areItemsTheSame(Respuesta a, Respuesta b) {
    // TODO: implement areItemsTheSame
    return a.cod == b.cod;
  }

  @override
  Future<void> fetchData(int page) async {
    // TODO: implement fetchData
    final total = await repository.getPassengersList(page);
    setTotal(total);
  }

  @override
  Stream<PaginationState<List<Respuesta>>> streamSubscription() => repository.result;

}