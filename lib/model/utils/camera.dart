import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../visitaDomiciliaria/t_respuestaprimeravisita.dart';
import 'cameraBuild.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatelessWidget {
  RespuestaPrimeraVisita? formDataModel;
  int? index;
  /// Default Constructor
  CameraApp(this.formDataModel, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraHome(formDataModel, index),
    );
  }
}