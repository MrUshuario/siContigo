import 'dart:async';

import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:sicontigo/model/t_formulario.dart';

import '../../../infraestructure/repository/formdatarepository_formulario.dart';
import '../../../model/t_visita.dart';

class FormDataModelViewModel with PaginationViewModel<Formulario> {

  final repository = FormDataRepository();

  @override
  Function(Formulario  a, Formulario  b) compare = ((a, b) => a.cod.toString().compareTo(b.cod.toString()));

  @override
  bool  sortItems = false;

  @override
  bool areItemsTheSame(Formulario a, Formulario b) {
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
  Stream<PaginationState<List<Formulario>>> streamSubscription() => repository.result;

}