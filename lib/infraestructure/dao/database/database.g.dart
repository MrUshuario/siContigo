// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FormDataModelDaoFormulario? _formDataModelDaoFormularioInstance;

  FormDataModelDaoRespuestaunovisita? _formDataModelDaoRespuestaInstance;

  FormDataModelDaoRespuestaBACKUPunovisita?
      _formDataModelDaoRespuestaBACKUPInstance;

  FormDataModelDaoPadron? _formDataModelDaoPadronInstance;

  FormDataModelDaoPadronLogin? _formDataModelDaoPadronLoginInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Formulario` (`cod` INTEGER PRIMARY KEY AUTOINCREMENT, `pregunta` TEXT, `tipoOpcion` TEXT, `puntaje` TEXT, `tipoRepuesta` INTEGER, `id` INTEGER, `idformato` INTEGER, `texto` TEXT, `titulo` TEXT, `idseccion` INTEGER, `descripcion` TEXT, `id_tipo_respuesta` INTEGER, `id_seccion` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RespuestaPrimeraVisita` (`cod` INTEGER PRIMARY KEY AUTOINCREMENT, `idformato` INTEGER, `id_usuario` INTEGER, `fecha` TEXT, `respuestas` TEXT, `puntaje` INTEGER, `longitud` TEXT, `latitud` TEXT, `id_gestor` INTEGER, `tipoencuesta` INTEGER, `p01CobroPension` INTEGER, `p02TipoMeses` INTEGER, `p03Check` TEXT, `p03CheckEspecificar` TEXT, `p04Check` TEXT, `p05pension` INTEGER, `p06Establecimiento` INTEGER, `p06EstablecimientoESPECIFICAR` TEXT, `p07Atendio` INTEGER, `p08Check` TEXT, `p08CheckEspecificar` TEXT, `p09Check` TEXT, `p09CheckEspecificar` TEXT, `p10Frecuencia` INTEGER, `p11Vive` INTEGER, `p12Familia` INTEGER, `p12FamiliaB` INTEGER, `p13Ayudas` INTEGER, `p13AyudasB` INTEGER, `p14Ingreso` INTEGER, `p15Tipovivienda` INTEGER, `p15TipoviviendaB` INTEGER, `p16Riesgo` INTEGER, `p16RiesgoB` INTEGER, `p17Check` TEXT, `p17CheckEspecificar` TEXT, `p18Emprendimiento` INTEGER, `p01percepcion` TEXT, `p02percepcion` TEXT, `p03percepcion` TEXT, `p04percepcion` TEXT, `p05percepcion` INTEGER, `p06percepcion` TEXT, `p07percepcion` TEXT, `p08percepcion` TEXT, `p09percepcion` INTEGER, `p10percepcion` INTEGER, `p11percepcion` INTEGER, `p12percepcion` TEXT, `p13percepcion` INTEGER, `p14percepcion` INTEGER, `p15percepcion` INTEGER, `p16percepcion` INTEGER, `p17percepcion` INTEGER, `p18percepcion` INTEGER, `p19percepcion` TEXT, `p20percepcion` INTEGER, `p21percepcion` INTEGER, `p22percepcion` INTEGER, `p22percepcionEspecificar` TEXT, `p23percepcion` INTEGER, `p24percepcion` INTEGER, `p25percepcion` INTEGER, `p26percepcion` INTEGER, `p27percepcion` INTEGER, `p28percepcion` INTEGER, `p29percepcion` INTEGER, `p30percepcion` INTEGER, `p31percepcion` INTEGER, `p32percepcion` INTEGER, `p33percepcion` INTEGER, `p34percepcion` INTEGER, `p35percepcion` INTEGER, `p36percepcion` INTEGER, `p37percepcion` INTEGER, `p38percepcion` INTEGER, `p39percepcion` INTEGER, `p40percepcion` INTEGER, `p41percepcion` INTEGER, `p42percepcion` TEXT, `p43percepcion` INTEGER, `p44percepcion` INTEGER, `p45percepcion` INTEGER, `p46percepcion` INTEGER, `p47percepcion` INTEGER, `p48percepcion` INTEGER, `p49percepcion` INTEGER, `p50percepcion` INTEGER, `p51percepcion` INTEGER, `p52percepcion` INTEGER, `p53percepcion` INTEGER, `p54percepcion` INTEGER, `p55percepcion` INTEGER, `p56percepcion` INTEGER, `p57percepcion` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RespuestaENVIO` (`idformato` INTEGER PRIMARY KEY AUTOINCREMENT, `id_usuario` INTEGER, `fecha` TEXT, `respuestas` TEXT, `puntaje` INTEGER, `longitud` TEXT, `latitud` TEXT, `id_gestor` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RespuestaBACKUPprimeravisita` (`cod` INTEGER PRIMARY KEY AUTOINCREMENT, `idformato` INTEGER, `id_usuario` INTEGER, `fecha` TEXT, `respuestas` TEXT, `puntaje` INTEGER, `longitud` TEXT, `latitud` TEXT, `id_gestor` INTEGER, `p01CobroPension` INTEGER, `p02TipoMeses` INTEGER, `p03Check` TEXT, `p03CheckEspecificar` TEXT, `p04Check` TEXT, `p05pension` INTEGER, `p06Establecimiento` INTEGER, `p06EstablecimientoESPECIFICAR` TEXT, `p07Atendio` INTEGER, `p08Check` TEXT, `p08CheckEspecificar` TEXT, `p09Check` TEXT, `p09CheckEspecificar` TEXT, `p10Frecuencia` INTEGER, `p11Vive` INTEGER, `p12Familia` INTEGER, `p12FamiliaB` INTEGER, `p13Ayudas` INTEGER, `p13AyudasB` INTEGER, `p14Ingreso` INTEGER, `p15Tipovivienda` INTEGER, `p15TipoviviendaB` INTEGER, `p16Riesgo` INTEGER, `p16RiesgoB` INTEGER, `p17Check` TEXT, `p17CheckEspecificar` TEXT, `p18Emprendimiento` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Padron` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fechaCorte` TEXT, `hogarUbigeo` TEXT, `hogarDepartamento` TEXT, `hogarRegion` TEXT, `hogarProvincia` TEXT, `hogarDistrito` TEXT, `hogarNombreCcpp` TEXT, `hogarDireccionDescripcion` TEXT, `area` TEXT, `comunidadNativa` TEXT, `puebloIndigena` TEXT, `saldoCuenta` TEXT, `estadoCuenta` TEXT, `tarjetizacion` TEXT, `tipoDoc` TEXT, `dniCe` TEXT, `apPaterno` TEXT, `apMaterno` TEXT, `nombre` TEXT, `fechaNacimiento` TEXT, `edadPadron` TEXT, `sexo` TEXT, `telefonoUsuario` TEXT, `cse` TEXT, `vigenciaCse` TEXT, `condicionEdad` TEXT, `rangoEdad` TEXT, `estadoActivo` TEXT, `estadoDetalle` TEXT, `ingreso` TEXT, `ultimoPadronAfiliado` TEXT, `motivoDesafiliacionSuspencion` TEXT, `detalleDesafiliacionSuspencion` TEXT, `alertaGeneral` TEXT, `recomendacion` TEXT, `tieneAutorizacion` TEXT, `estadoAutorizacion` TEXT, `detalleObservacion` TEXT, `rde` TEXT, `fechaRde` TEXT, `parentezco` TEXT, `nombreAutorizado` TEXT, `tipoDocAutorizado` TEXT, `dniAutorizado` TEXT, `autorizadoSexo` TEXT, `telefonoAutorizado` TEXT, `correoAutorizado` TEXT, `prioridad` TEXT, `tipoDistrito` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PadronLogin` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nombre` TEXT, `apellidos` TEXT, `hogarDepartamento` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FormDataModelDaoFormulario get formDataModelDaoFormulario {
    return _formDataModelDaoFormularioInstance ??=
        _$FormDataModelDaoFormulario(database, changeListener);
  }

  @override
  FormDataModelDaoRespuestaunovisita get formDataModelDaoRespuesta {
    return _formDataModelDaoRespuestaInstance ??=
        _$FormDataModelDaoRespuestaunovisita(database, changeListener);
  }

  @override
  FormDataModelDaoRespuestaBACKUPunovisita get formDataModelDaoRespuestaBACKUP {
    return _formDataModelDaoRespuestaBACKUPInstance ??=
        _$FormDataModelDaoRespuestaBACKUPunovisita(database, changeListener);
  }

  @override
  FormDataModelDaoPadron get formDataModelDaoPadron {
    return _formDataModelDaoPadronInstance ??=
        _$FormDataModelDaoPadron(database, changeListener);
  }

  @override
  FormDataModelDaoPadronLogin get formDataModelDaoPadronLogin {
    return _formDataModelDaoPadronLoginInstance ??=
        _$FormDataModelDaoPadronLogin(database, changeListener);
  }
}

class _$FormDataModelDaoFormulario extends FormDataModelDaoFormulario {
  _$FormDataModelDaoFormulario(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _formularioInsertionAdapter = InsertionAdapter(
            database,
            'Formulario',
            (Formulario item) => <String, Object?>{
                  'cod': item.cod,
                  'pregunta': item.pregunta,
                  'tipoOpcion': item.tipoOpcion,
                  'puntaje': item.puntaje,
                  'tipoRepuesta': item.tipoRepuesta,
                  'id': item.id,
                  'idformato': item.idformato,
                  'texto': item.texto,
                  'titulo': item.titulo,
                  'idseccion': item.idseccion,
                  'descripcion': item.descripcion,
                  'id_tipo_respuesta': item.id_tipo_respuesta,
                  'id_seccion': item.id_seccion
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Formulario> _formularioInsertionAdapter;

  @override
  Future<List<Formulario>> findFormDataModelORIGINAL() async {
    return _queryAdapter.queryList('SELECT * FROM Formulario',
        mapper: (Map<String, Object?> row) => Formulario(
            cod: row['cod'] as int?,
            pregunta: row['pregunta'] as String?,
            tipoOpcion: row['tipoOpcion'] as String?,
            puntaje: row['puntaje'] as String?,
            tipoRepuesta: row['tipoRepuesta'] as int?,
            id: row['id'] as int?,
            idformato: row['idformato'] as int?,
            texto: row['texto'] as String?,
            titulo: row['titulo'] as String?,
            idseccion: row['idseccion'] as int?,
            descripcion: row['descripcion'] as String?,
            id_tipo_respuesta: row['id_tipo_respuesta'] as int?,
            id_seccion: row['id_seccion'] as int?));
  }

  @override
  Future<List<Formulario>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Formulario LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Formulario(
            cod: row['cod'] as int?,
            pregunta: row['pregunta'] as String?,
            tipoOpcion: row['tipoOpcion'] as String?,
            puntaje: row['puntaje'] as String?,
            tipoRepuesta: row['tipoRepuesta'] as int?,
            id: row['id'] as int?,
            idformato: row['idformato'] as int?,
            texto: row['texto'] as String?,
            titulo: row['titulo'] as String?,
            idseccion: row['idseccion'] as int?,
            descripcion: row['descripcion'] as String?,
            id_tipo_respuesta: row['id_tipo_respuesta'] as int?,
            id_seccion: row['id_seccion'] as int?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<Formulario>> findAllFormulario() async {
    return _queryAdapter.queryList('SELECT * FROM Formulario',
        mapper: (Map<String, Object?> row) => Formulario(
            cod: row['cod'] as int?,
            pregunta: row['pregunta'] as String?,
            tipoOpcion: row['tipoOpcion'] as String?,
            puntaje: row['puntaje'] as String?,
            tipoRepuesta: row['tipoRepuesta'] as int?,
            id: row['id'] as int?,
            idformato: row['idformato'] as int?,
            texto: row['texto'] as String?,
            titulo: row['titulo'] as String?,
            idseccion: row['idseccion'] as int?,
            descripcion: row['descripcion'] as String?,
            id_tipo_respuesta: row['id_tipo_respuesta'] as int?,
            id_seccion: row['id_seccion'] as int?));
  }

  @override
  Future<String?> findAllFormularioID(int cod) async {
    return _queryAdapter.query('SELECT cod FROM Formulario WHERE cod = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [cod]);
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Formulario',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> totalFormDataModelsCIRCLE() async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM Formulario WHERE tipoRepuesta = 2',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> totalFormDataModelsCHECKS() async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM Formulario WHERE tipoRepuesta = 4',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<Formulario>> findAllFormularioCHECK() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Formulario WHERE tipoRepuesta = 4',
        mapper: (Map<String, Object?> row) => Formulario(
            cod: row['cod'] as int?,
            pregunta: row['pregunta'] as String?,
            tipoOpcion: row['tipoOpcion'] as String?,
            puntaje: row['puntaje'] as String?,
            tipoRepuesta: row['tipoRepuesta'] as int?,
            id: row['id'] as int?,
            idformato: row['idformato'] as int?,
            texto: row['texto'] as String?,
            titulo: row['titulo'] as String?,
            idseccion: row['idseccion'] as int?,
            descripcion: row['descripcion'] as String?,
            id_tipo_respuesta: row['id_tipo_respuesta'] as int?,
            id_seccion: row['id_seccion'] as int?));
  }

  @override
  Future<int?> totalFormDataModelsINPUT() async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM Formulario WHERE tipoRepuesta = 1',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> totalFormDataModelsSECCION(int id) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM Formulario WHERE id_seccion = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<List<Formulario>> findFormDataModelSECCION(
    int offset,
    int perPage,
    int id,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Formulario WHERE id_seccion = ?3  LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Formulario(
            cod: row['cod'] as int?,
            pregunta: row['pregunta'] as String?,
            tipoOpcion: row['tipoOpcion'] as String?,
            puntaje: row['puntaje'] as String?,
            tipoRepuesta: row['tipoRepuesta'] as int?,
            id: row['id'] as int?,
            idformato: row['idformato'] as int?,
            texto: row['texto'] as String?,
            titulo: row['titulo'] as String?,
            idseccion: row['idseccion'] as int?,
            descripcion: row['descripcion'] as String?,
            id_tipo_respuesta: row['id_tipo_respuesta'] as int?,
            id_seccion: row['id_seccion'] as int?),
        arguments: [offset, perPage, id]);
  }

  @override
  Future<int?> BorrarFormDataModels(int cod) async {
    return _queryAdapter.query('DELETE FROM Html WHERE cod = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cod]);
  }

  @override
  Future<int?> BorrarTodo() async {
    return _queryAdapter.query('DELETE FROM Formulario',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModel(Formulario formDataModel) async {
    await _formularioInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoRespuestaunovisita
    extends FormDataModelDaoRespuestaunovisita {
  _$FormDataModelDaoRespuestaunovisita(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _respuestaPrimeraVisitaInsertionAdapter = InsertionAdapter(
            database,
            'RespuestaPrimeraVisita',
            (RespuestaPrimeraVisita item) => <String, Object?>{
                  'cod': item.cod,
                  'idformato': item.idformato,
                  'id_usuario': item.id_usuario,
                  'fecha': item.fecha,
                  'respuestas': item.respuestas,
                  'puntaje': item.puntaje,
                  'longitud': item.longitud,
                  'latitud': item.latitud,
                  'id_gestor': item.id_gestor,
                  'tipoencuesta': item.tipoencuesta,
                  'p01CobroPension': item.p01CobroPension,
                  'p02TipoMeses': item.p02TipoMeses,
                  'p03Check': item.p03Check,
                  'p03CheckEspecificar': item.p03CheckEspecificar,
                  'p04Check': item.p04Check,
                  'p05pension': item.p05pension,
                  'p06Establecimiento': item.p06Establecimiento,
                  'p06EstablecimientoESPECIFICAR':
                      item.p06EstablecimientoESPECIFICAR,
                  'p07Atendio': item.p07Atendio,
                  'p08Check': item.p08Check,
                  'p08CheckEspecificar': item.p08CheckEspecificar,
                  'p09Check': item.p09Check,
                  'p09CheckEspecificar': item.p09CheckEspecificar,
                  'p10Frecuencia': item.p10Frecuencia,
                  'p11Vive': item.p11Vive,
                  'p12Familia': item.p12Familia,
                  'p12FamiliaB': item.p12FamiliaB,
                  'p13Ayudas': item.p13Ayudas,
                  'p13AyudasB': item.p13AyudasB,
                  'p14Ingreso': item.p14Ingreso,
                  'p15Tipovivienda': item.p15Tipovivienda,
                  'p15TipoviviendaB': item.p15TipoviviendaB,
                  'p16Riesgo': item.p16Riesgo,
                  'p16RiesgoB': item.p16RiesgoB,
                  'p17Check': item.p17Check,
                  'p17CheckEspecificar': item.p17CheckEspecificar,
                  'p18Emprendimiento': item.p18Emprendimiento,
                  'p01percepcion': item.p01percepcion,
                  'p02percepcion': item.p02percepcion,
                  'p03percepcion': item.p03percepcion,
                  'p04percepcion': item.p04percepcion,
                  'p05percepcion': item.p05percepcion,
                  'p06percepcion': item.p06percepcion,
                  'p07percepcion': item.p07percepcion,
                  'p08percepcion': item.p08percepcion,
                  'p09percepcion': item.p09percepcion,
                  'p10percepcion': item.p10percepcion,
                  'p11percepcion': item.p11percepcion,
                  'p12percepcion': item.p12percepcion,
                  'p13percepcion': item.p13percepcion,
                  'p14percepcion': item.p14percepcion,
                  'p15percepcion': item.p15percepcion,
                  'p16percepcion': item.p16percepcion,
                  'p17percepcion': item.p17percepcion,
                  'p18percepcion': item.p18percepcion,
                  'p19percepcion': item.p19percepcion,
                  'p20percepcion': item.p20percepcion,
                  'p21percepcion': item.p21percepcion,
                  'p22percepcion': item.p22percepcion,
                  'p22percepcionEspecificar': item.p22percepcionEspecificar,
                  'p23percepcion': item.p23percepcion,
                  'p24percepcion': item.p24percepcion,
                  'p25percepcion': item.p25percepcion,
                  'p26percepcion': item.p26percepcion,
                  'p27percepcion': item.p27percepcion,
                  'p28percepcion': item.p28percepcion,
                  'p29percepcion': item.p29percepcion,
                  'p30percepcion': item.p30percepcion,
                  'p31percepcion': item.p31percepcion,
                  'p32percepcion': item.p32percepcion,
                  'p33percepcion': item.p33percepcion,
                  'p34percepcion': item.p34percepcion,
                  'p35percepcion': item.p35percepcion,
                  'p36percepcion': item.p36percepcion,
                  'p37percepcion': item.p37percepcion,
                  'p38percepcion': item.p38percepcion,
                  'p39percepcion': item.p39percepcion,
                  'p40percepcion': item.p40percepcion,
                  'p41percepcion': item.p41percepcion,
                  'p42percepcion': item.p42percepcion,
                  'p43percepcion': item.p43percepcion,
                  'p44percepcion': item.p44percepcion,
                  'p45percepcion': item.p45percepcion,
                  'p46percepcion': item.p46percepcion,
                  'p47percepcion': item.p47percepcion,
                  'p48percepcion': item.p48percepcion,
                  'p49percepcion': item.p49percepcion,
                  'p50percepcion': item.p50percepcion,
                  'p51percepcion': item.p51percepcion,
                  'p52percepcion': item.p52percepcion,
                  'p53percepcion': item.p53percepcion,
                  'p54percepcion': item.p54percepcion,
                  'p55percepcion': item.p55percepcion,
                  'p56percepcion': item.p56percepcion,
                  'p57percepcion': item.p57percepcion
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RespuestaPrimeraVisita>
      _respuestaPrimeraVisitaInsertionAdapter;

  @override
  Future<List<RespuestaPrimeraVisita>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM RespuestaPrimeraVisita LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => RespuestaPrimeraVisita(
            cod: row['cod'] as int?,
            idformato: row['idformato'] as int?,
            id_usuario: row['id_usuario'] as int?,
            fecha: row['fecha'] as String?,
            respuestas: row['respuestas'] as String?,
            puntaje: row['puntaje'] as int?,
            longitud: row['longitud'] as String?,
            latitud: row['latitud'] as String?,
            id_gestor: row['id_gestor'] as int?,
            p01CobroPension: row['p01CobroPension'] as int?,
            p02TipoMeses: row['p02TipoMeses'] as int?,
            p03Check: row['p03Check'] as String?,
            p03CheckEspecificar: row['p03CheckEspecificar'] as String?,
            p04Check: row['p04Check'] as String?,
            p05pension: row['p05pension'] as int?,
            p06Establecimiento: row['p06Establecimiento'] as int?,
            p06EstablecimientoESPECIFICAR:
                row['p06EstablecimientoESPECIFICAR'] as String?,
            p07Atendio: row['p07Atendio'] as int?,
            p08Check: row['p08Check'] as String?,
            p08CheckEspecificar: row['p08CheckEspecificar'] as String?,
            p09Check: row['p09Check'] as String?,
            p09CheckEspecificar: row['p09CheckEspecificar'] as String?,
            p10Frecuencia: row['p10Frecuencia'] as int?,
            p11Vive: row['p11Vive'] as int?,
            p12Familia: row['p12Familia'] as int?,
            p12FamiliaB: row['p12FamiliaB'] as int?,
            p13Ayudas: row['p13Ayudas'] as int?,
            p13AyudasB: row['p13AyudasB'] as int?,
            p14Ingreso: row['p14Ingreso'] as int?,
            p15Tipovivienda: row['p15Tipovivienda'] as int?,
            p15TipoviviendaB: row['p15TipoviviendaB'] as int?,
            p16Riesgo: row['p16Riesgo'] as int?,
            p16RiesgoB: row['p16RiesgoB'] as int?,
            p17Check: row['p17Check'] as String?,
            p17CheckEspecificar: row['p17CheckEspecificar'] as String?,
            p18Emprendimiento: row['p18Emprendimiento'] as int?,
            tipoencuesta: row['tipoencuesta'] as int?,
            p01percepcion: row['p01percepcion'] as String?,
            p02percepcion: row['p02percepcion'] as String?,
            p03percepcion: row['p03percepcion'] as String?,
            p04percepcion: row['p04percepcion'] as String?,
            p05percepcion: row['p05percepcion'] as int?,
            p06percepcion: row['p06percepcion'] as String?,
            p07percepcion: row['p07percepcion'] as String?,
            p08percepcion: row['p08percepcion'] as String?,
            p09percepcion: row['p09percepcion'] as int?,
            p10percepcion: row['p10percepcion'] as int?,
            p11percepcion: row['p11percepcion'] as int?,
            p12percepcion: row['p12percepcion'] as String?,
            p13percepcion: row['p13percepcion'] as int?,
            p14percepcion: row['p14percepcion'] as int?,
            p15percepcion: row['p15percepcion'] as int?,
            p16percepcion: row['p16percepcion'] as int?,
            p17percepcion: row['p17percepcion'] as int?,
            p18percepcion: row['p18percepcion'] as int?,
            p19percepcion: row['p19percepcion'] as String?,
            p20percepcion: row['p20percepcion'] as int?,
            p21percepcion: row['p21percepcion'] as int?,
            p22percepcion: row['p22percepcion'] as int?,
            p23percepcion: row['p23percepcion'] as int?,
            p24percepcion: row['p24percepcion'] as int?,
            p25percepcion: row['p25percepcion'] as int?,
            p26percepcion: row['p26percepcion'] as int?,
            p27percepcion: row['p27percepcion'] as int?,
            p28percepcion: row['p28percepcion'] as int?,
            p29percepcion: row['p29percepcion'] as int?,
            p30percepcion: row['p30percepcion'] as int?,
            p31percepcion: row['p31percepcion'] as int?,
            p32percepcion: row['p32percepcion'] as int?,
            p33percepcion: row['p33percepcion'] as int?,
            p34percepcion: row['p34percepcion'] as int?,
            p35percepcion: row['p35percepcion'] as int?,
            p36percepcion: row['p36percepcion'] as int?,
            p37percepcion: row['p37percepcion'] as int?,
            p38percepcion: row['p38percepcion'] as int?,
            p39percepcion: row['p39percepcion'] as int?,
            p40percepcion: row['p40percepcion'] as int?,
            p41percepcion: row['p41percepcion'] as int?,
            p42percepcion: row['p42percepcion'] as String?,
            p43percepcion: row['p43percepcion'] as int?,
            p44percepcion: row['p44percepcion'] as int?,
            p45percepcion: row['p45percepcion'] as int?,
            p46percepcion: row['p46percepcion'] as int?,
            p47percepcion: row['p47percepcion'] as int?,
            p48percepcion: row['p48percepcion'] as int?,
            p49percepcion: row['p49percepcion'] as int?,
            p50percepcion: row['p50percepcion'] as int?,
            p51percepcion: row['p51percepcion'] as int?,
            p52percepcion: row['p52percepcion'] as int?,
            p53percepcion: row['p53percepcion'] as int?,
            p54percepcion: row['p54percepcion'] as int?,
            p55percepcion: row['p55percepcion'] as int?,
            p56percepcion: row['p56percepcion'] as int?,
            p57percepcion: row['p57percepcion'] as int?,
            p22percepcionEspecificar:
                row['p22percepcionEspecificar'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<RespuestaPrimeraVisita>> findAllRespuesta() async {
    return _queryAdapter.queryList('SELECT * FROM RespuestaPrimeraVisita',
        mapper: (Map<String, Object?> row) => RespuestaPrimeraVisita(
            cod: row['cod'] as int?,
            idformato: row['idformato'] as int?,
            id_usuario: row['id_usuario'] as int?,
            fecha: row['fecha'] as String?,
            respuestas: row['respuestas'] as String?,
            puntaje: row['puntaje'] as int?,
            longitud: row['longitud'] as String?,
            latitud: row['latitud'] as String?,
            id_gestor: row['id_gestor'] as int?,
            p01CobroPension: row['p01CobroPension'] as int?,
            p02TipoMeses: row['p02TipoMeses'] as int?,
            p03Check: row['p03Check'] as String?,
            p03CheckEspecificar: row['p03CheckEspecificar'] as String?,
            p04Check: row['p04Check'] as String?,
            p05pension: row['p05pension'] as int?,
            p06Establecimiento: row['p06Establecimiento'] as int?,
            p06EstablecimientoESPECIFICAR:
                row['p06EstablecimientoESPECIFICAR'] as String?,
            p07Atendio: row['p07Atendio'] as int?,
            p08Check: row['p08Check'] as String?,
            p08CheckEspecificar: row['p08CheckEspecificar'] as String?,
            p09Check: row['p09Check'] as String?,
            p09CheckEspecificar: row['p09CheckEspecificar'] as String?,
            p10Frecuencia: row['p10Frecuencia'] as int?,
            p11Vive: row['p11Vive'] as int?,
            p12Familia: row['p12Familia'] as int?,
            p12FamiliaB: row['p12FamiliaB'] as int?,
            p13Ayudas: row['p13Ayudas'] as int?,
            p13AyudasB: row['p13AyudasB'] as int?,
            p14Ingreso: row['p14Ingreso'] as int?,
            p15Tipovivienda: row['p15Tipovivienda'] as int?,
            p15TipoviviendaB: row['p15TipoviviendaB'] as int?,
            p16Riesgo: row['p16Riesgo'] as int?,
            p16RiesgoB: row['p16RiesgoB'] as int?,
            p17Check: row['p17Check'] as String?,
            p17CheckEspecificar: row['p17CheckEspecificar'] as String?,
            p18Emprendimiento: row['p18Emprendimiento'] as int?,
            tipoencuesta: row['tipoencuesta'] as int?,
            p01percepcion: row['p01percepcion'] as String?,
            p02percepcion: row['p02percepcion'] as String?,
            p03percepcion: row['p03percepcion'] as String?,
            p04percepcion: row['p04percepcion'] as String?,
            p05percepcion: row['p05percepcion'] as int?,
            p06percepcion: row['p06percepcion'] as String?,
            p07percepcion: row['p07percepcion'] as String?,
            p08percepcion: row['p08percepcion'] as String?,
            p09percepcion: row['p09percepcion'] as int?,
            p10percepcion: row['p10percepcion'] as int?,
            p11percepcion: row['p11percepcion'] as int?,
            p12percepcion: row['p12percepcion'] as String?,
            p13percepcion: row['p13percepcion'] as int?,
            p14percepcion: row['p14percepcion'] as int?,
            p15percepcion: row['p15percepcion'] as int?,
            p16percepcion: row['p16percepcion'] as int?,
            p17percepcion: row['p17percepcion'] as int?,
            p18percepcion: row['p18percepcion'] as int?,
            p19percepcion: row['p19percepcion'] as String?,
            p20percepcion: row['p20percepcion'] as int?,
            p21percepcion: row['p21percepcion'] as int?,
            p22percepcion: row['p22percepcion'] as int?,
            p23percepcion: row['p23percepcion'] as int?,
            p24percepcion: row['p24percepcion'] as int?,
            p25percepcion: row['p25percepcion'] as int?,
            p26percepcion: row['p26percepcion'] as int?,
            p27percepcion: row['p27percepcion'] as int?,
            p28percepcion: row['p28percepcion'] as int?,
            p29percepcion: row['p29percepcion'] as int?,
            p30percepcion: row['p30percepcion'] as int?,
            p31percepcion: row['p31percepcion'] as int?,
            p32percepcion: row['p32percepcion'] as int?,
            p33percepcion: row['p33percepcion'] as int?,
            p34percepcion: row['p34percepcion'] as int?,
            p35percepcion: row['p35percepcion'] as int?,
            p36percepcion: row['p36percepcion'] as int?,
            p37percepcion: row['p37percepcion'] as int?,
            p38percepcion: row['p38percepcion'] as int?,
            p39percepcion: row['p39percepcion'] as int?,
            p40percepcion: row['p40percepcion'] as int?,
            p41percepcion: row['p41percepcion'] as int?,
            p42percepcion: row['p42percepcion'] as String?,
            p43percepcion: row['p43percepcion'] as int?,
            p44percepcion: row['p44percepcion'] as int?,
            p45percepcion: row['p45percepcion'] as int?,
            p46percepcion: row['p46percepcion'] as int?,
            p47percepcion: row['p47percepcion'] as int?,
            p48percepcion: row['p48percepcion'] as int?,
            p49percepcion: row['p49percepcion'] as int?,
            p50percepcion: row['p50percepcion'] as int?,
            p51percepcion: row['p51percepcion'] as int?,
            p52percepcion: row['p52percepcion'] as int?,
            p53percepcion: row['p53percepcion'] as int?,
            p54percepcion: row['p54percepcion'] as int?,
            p55percepcion: row['p55percepcion'] as int?,
            p56percepcion: row['p56percepcion'] as int?,
            p57percepcion: row['p57percepcion'] as int?,
            p22percepcionEspecificar:
                row['p22percepcionEspecificar'] as String?));
  }

  @override
  Future<String?> findAllRespuestaID(int cod) async {
    return _queryAdapter.query(
        'SELECT Respuestacodigo FROM RespuestaPrimeraVisita WHERE cod = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [cod]);
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM RespuestaPrimeraVisita',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int cod) async {
    return _queryAdapter.query(
        'DELETE FROM RespuestaPrimeraVisita WHERE cod = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cod]);
  }

  @override
  Future<int?> BorrarTodo() async {
    return _queryAdapter.query('DELETE FROM RespuestaPrimeraVisita',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModel(RespuestaPrimeraVisita formDataModel) async {
    await _respuestaPrimeraVisitaInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoRespuestaBACKUPunovisita
    extends FormDataModelDaoRespuestaBACKUPunovisita {
  _$FormDataModelDaoRespuestaBACKUPunovisita(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _respuestaBACKUPprimeravisitaInsertionAdapter = InsertionAdapter(
            database,
            'RespuestaBACKUPprimeravisita',
            (RespuestaBACKUPprimeravisita item) => <String, Object?>{
                  'cod': item.cod,
                  'idformato': item.idformato,
                  'id_usuario': item.id_usuario,
                  'fecha': item.fecha,
                  'respuestas': item.respuestas,
                  'puntaje': item.puntaje,
                  'longitud': item.longitud,
                  'latitud': item.latitud,
                  'id_gestor': item.id_gestor,
                  'p01CobroPension': item.p01CobroPension,
                  'p02TipoMeses': item.p02TipoMeses,
                  'p03Check': item.p03Check,
                  'p03CheckEspecificar': item.p03CheckEspecificar,
                  'p04Check': item.p04Check,
                  'p05pension': item.p05pension,
                  'p06Establecimiento': item.p06Establecimiento,
                  'p06EstablecimientoESPECIFICAR':
                      item.p06EstablecimientoESPECIFICAR,
                  'p07Atendio': item.p07Atendio,
                  'p08Check': item.p08Check,
                  'p08CheckEspecificar': item.p08CheckEspecificar,
                  'p09Check': item.p09Check,
                  'p09CheckEspecificar': item.p09CheckEspecificar,
                  'p10Frecuencia': item.p10Frecuencia,
                  'p11Vive': item.p11Vive,
                  'p12Familia': item.p12Familia,
                  'p12FamiliaB': item.p12FamiliaB,
                  'p13Ayudas': item.p13Ayudas,
                  'p13AyudasB': item.p13AyudasB,
                  'p14Ingreso': item.p14Ingreso,
                  'p15Tipovivienda': item.p15Tipovivienda,
                  'p15TipoviviendaB': item.p15TipoviviendaB,
                  'p16Riesgo': item.p16Riesgo,
                  'p16RiesgoB': item.p16RiesgoB,
                  'p17Check': item.p17Check,
                  'p17CheckEspecificar': item.p17CheckEspecificar,
                  'p18Emprendimiento': item.p18Emprendimiento
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RespuestaBACKUPprimeravisita>
      _respuestaBACKUPprimeravisitaInsertionAdapter;

  @override
  Future<List<RespuestaBACKUPprimeravisita>> findAllRespuesta() async {
    return _queryAdapter.queryList('SELECT * FROM RespuestaBACKUPprimeravisita',
        mapper: (Map<String, Object?> row) => RespuestaBACKUPprimeravisita(
            cod: row['cod'] as int?,
            idformato: row['idformato'] as int?,
            id_usuario: row['id_usuario'] as int?,
            fecha: row['fecha'] as String?,
            respuestas: row['respuestas'] as String?,
            puntaje: row['puntaje'] as int?,
            longitud: row['longitud'] as String?,
            latitud: row['latitud'] as String?,
            id_gestor: row['id_gestor'] as int?,
            p01CobroPension: row['p01CobroPension'] as int?,
            p02TipoMeses: row['p02TipoMeses'] as int?,
            p03Check: row['p03Check'] as String?,
            p03CheckEspecificar: row['p03CheckEspecificar'] as String?,
            p04Check: row['p04Check'] as String?,
            p05pension: row['p05pension'] as int?,
            p06Establecimiento: row['p06Establecimiento'] as int?,
            p06EstablecimientoESPECIFICAR:
                row['p06EstablecimientoESPECIFICAR'] as String?,
            p07Atendio: row['p07Atendio'] as int?,
            p08Check: row['p08Check'] as String?,
            p08CheckEspecificar: row['p08CheckEspecificar'] as String?,
            p09Check: row['p09Check'] as String?,
            p09CheckEspecificar: row['p09CheckEspecificar'] as String?,
            p10Frecuencia: row['p10Frecuencia'] as int?,
            p11Vive: row['p11Vive'] as int?,
            p12Familia: row['p12Familia'] as int?,
            p12FamiliaB: row['p12FamiliaB'] as int?,
            p13Ayudas: row['p13Ayudas'] as int?,
            p13AyudasB: row['p13AyudasB'] as int?,
            p14Ingreso: row['p14Ingreso'] as int?,
            p15Tipovivienda: row['p15Tipovivienda'] as int?,
            p15TipoviviendaB: row['p15TipoviviendaB'] as int?,
            p16Riesgo: row['p16Riesgo'] as int?,
            p16RiesgoB: row['p16RiesgoB'] as int?,
            p17Check: row['p17Check'] as String?,
            p17CheckEspecificar: row['p17CheckEspecificar'] as String?,
            p18Emprendimiento: row['p18Emprendimiento'] as int?));
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM RespuestaBACKUPprimeravisita',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarTodo() async {
    return _queryAdapter.query('DELETE FROM RespuestaBACKUPprimeravisita',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModel(
      RespuestaBACKUPprimeravisita formDataModel) async {
    await _respuestaBACKUPprimeravisitaInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoPadron extends FormDataModelDaoPadron {
  _$FormDataModelDaoPadron(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _padronInsertionAdapter = InsertionAdapter(
            database,
            'Padron',
            (Padron item) => <String, Object?>{
                  'id': item.id,
                  'fechaCorte': item.fechaCorte,
                  'hogarUbigeo': item.hogarUbigeo,
                  'hogarDepartamento': item.hogarDepartamento,
                  'hogarRegion': item.hogarRegion,
                  'hogarProvincia': item.hogarProvincia,
                  'hogarDistrito': item.hogarDistrito,
                  'hogarNombreCcpp': item.hogarNombreCcpp,
                  'hogarDireccionDescripcion': item.hogarDireccionDescripcion,
                  'area': item.area,
                  'comunidadNativa': item.comunidadNativa,
                  'puebloIndigena': item.puebloIndigena,
                  'saldoCuenta': item.saldoCuenta,
                  'estadoCuenta': item.estadoCuenta,
                  'tarjetizacion': item.tarjetizacion,
                  'tipoDoc': item.tipoDoc,
                  'dniCe': item.dniCe,
                  'apPaterno': item.apPaterno,
                  'apMaterno': item.apMaterno,
                  'nombre': item.nombre,
                  'fechaNacimiento': item.fechaNacimiento,
                  'edadPadron': item.edadPadron,
                  'sexo': item.sexo,
                  'telefonoUsuario': item.telefonoUsuario,
                  'cse': item.cse,
                  'vigenciaCse': item.vigenciaCse,
                  'condicionEdad': item.condicionEdad,
                  'rangoEdad': item.rangoEdad,
                  'estadoActivo': item.estadoActivo,
                  'estadoDetalle': item.estadoDetalle,
                  'ingreso': item.ingreso,
                  'ultimoPadronAfiliado': item.ultimoPadronAfiliado,
                  'motivoDesafiliacionSuspencion':
                      item.motivoDesafiliacionSuspencion,
                  'detalleDesafiliacionSuspencion':
                      item.detalleDesafiliacionSuspencion,
                  'alertaGeneral': item.alertaGeneral,
                  'recomendacion': item.recomendacion,
                  'tieneAutorizacion': item.tieneAutorizacion,
                  'estadoAutorizacion': item.estadoAutorizacion,
                  'detalleObservacion': item.detalleObservacion,
                  'rde': item.rde,
                  'fechaRde': item.fechaRde,
                  'parentezco': item.parentezco,
                  'nombreAutorizado': item.nombreAutorizado,
                  'tipoDocAutorizado': item.tipoDocAutorizado,
                  'dniAutorizado': item.dniAutorizado,
                  'autorizadoSexo': item.autorizadoSexo,
                  'telefonoAutorizado': item.telefonoAutorizado,
                  'correoAutorizado': item.correoAutorizado,
                  'prioridad': item.prioridad,
                  'tipoDistrito': item.tipoDistrito
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Padron> _padronInsertionAdapter;

  @override
  Future<List<Padron>> findAllPadron() async {
    return _queryAdapter.queryList('SELECT * FROM Padron',
        mapper: (Map<String, Object?> row) => Padron(
            id: row['id'] as int?,
            fechaCorte: row['fechaCorte'] as String?,
            hogarUbigeo: row['hogarUbigeo'] as String?,
            hogarDepartamento: row['hogarDepartamento'] as String?,
            hogarRegion: row['hogarRegion'] as String?,
            hogarProvincia: row['hogarProvincia'] as String?,
            hogarDistrito: row['hogarDistrito'] as String?,
            hogarNombreCcpp: row['hogarNombreCcpp'] as String?,
            hogarDireccionDescripcion:
                row['hogarDireccionDescripcion'] as String?,
            area: row['area'] as String?,
            comunidadNativa: row['comunidadNativa'] as String?,
            puebloIndigena: row['puebloIndigena'] as String?,
            saldoCuenta: row['saldoCuenta'] as String?,
            estadoCuenta: row['estadoCuenta'] as String?,
            tarjetizacion: row['tarjetizacion'] as String?,
            tipoDoc: row['tipoDoc'] as String?,
            dniCe: row['dniCe'] as String?,
            apPaterno: row['apPaterno'] as String?,
            apMaterno: row['apMaterno'] as String?,
            nombre: row['nombre'] as String?,
            fechaNacimiento: row['fechaNacimiento'] as String?,
            edadPadron: row['edadPadron'] as String?,
            sexo: row['sexo'] as String?,
            telefonoUsuario: row['telefonoUsuario'] as String?,
            cse: row['cse'] as String?,
            vigenciaCse: row['vigenciaCse'] as String?,
            condicionEdad: row['condicionEdad'] as String?,
            rangoEdad: row['rangoEdad'] as String?,
            estadoActivo: row['estadoActivo'] as String?,
            estadoDetalle: row['estadoDetalle'] as String?,
            ingreso: row['ingreso'] as String?,
            ultimoPadronAfiliado: row['ultimoPadronAfiliado'] as String?,
            motivoDesafiliacionSuspencion:
                row['motivoDesafiliacionSuspencion'] as String?,
            detalleDesafiliacionSuspencion:
                row['detalleDesafiliacionSuspencion'] as String?,
            alertaGeneral: row['alertaGeneral'] as String?,
            recomendacion: row['recomendacion'] as String?,
            tieneAutorizacion: row['tieneAutorizacion'] as String?,
            estadoAutorizacion: row['estadoAutorizacion'] as String?,
            detalleObservacion: row['detalleObservacion'] as String?,
            rde: row['rde'] as String?,
            fechaRde: row['fechaRde'] as String?,
            parentezco: row['parentezco'] as String?,
            nombreAutorizado: row['nombreAutorizado'] as String?,
            tipoDocAutorizado: row['tipoDocAutorizado'] as String?,
            dniAutorizado: row['dniAutorizado'] as String?,
            autorizadoSexo: row['autorizadoSexo'] as String?,
            telefonoAutorizado: row['telefonoAutorizado'] as String?,
            correoAutorizado: row['correoAutorizado'] as String?,
            prioridad: row['prioridad'] as String?,
            tipoDistrito: row['tipoDistrito'] as String?));
  }

  @override
  Future<List<Padron>> findAllPadronDNI(String id) async {
    return _queryAdapter.queryList('SELECT * FROM Padron WHERE dniCe = ?1',
        mapper: (Map<String, Object?> row) => Padron(
            id: row['id'] as int?,
            fechaCorte: row['fechaCorte'] as String?,
            hogarUbigeo: row['hogarUbigeo'] as String?,
            hogarDepartamento: row['hogarDepartamento'] as String?,
            hogarRegion: row['hogarRegion'] as String?,
            hogarProvincia: row['hogarProvincia'] as String?,
            hogarDistrito: row['hogarDistrito'] as String?,
            hogarNombreCcpp: row['hogarNombreCcpp'] as String?,
            hogarDireccionDescripcion:
                row['hogarDireccionDescripcion'] as String?,
            area: row['area'] as String?,
            comunidadNativa: row['comunidadNativa'] as String?,
            puebloIndigena: row['puebloIndigena'] as String?,
            saldoCuenta: row['saldoCuenta'] as String?,
            estadoCuenta: row['estadoCuenta'] as String?,
            tarjetizacion: row['tarjetizacion'] as String?,
            tipoDoc: row['tipoDoc'] as String?,
            dniCe: row['dniCe'] as String?,
            apPaterno: row['apPaterno'] as String?,
            apMaterno: row['apMaterno'] as String?,
            nombre: row['nombre'] as String?,
            fechaNacimiento: row['fechaNacimiento'] as String?,
            edadPadron: row['edadPadron'] as String?,
            sexo: row['sexo'] as String?,
            telefonoUsuario: row['telefonoUsuario'] as String?,
            cse: row['cse'] as String?,
            vigenciaCse: row['vigenciaCse'] as String?,
            condicionEdad: row['condicionEdad'] as String?,
            rangoEdad: row['rangoEdad'] as String?,
            estadoActivo: row['estadoActivo'] as String?,
            estadoDetalle: row['estadoDetalle'] as String?,
            ingreso: row['ingreso'] as String?,
            ultimoPadronAfiliado: row['ultimoPadronAfiliado'] as String?,
            motivoDesafiliacionSuspencion:
                row['motivoDesafiliacionSuspencion'] as String?,
            detalleDesafiliacionSuspencion:
                row['detalleDesafiliacionSuspencion'] as String?,
            alertaGeneral: row['alertaGeneral'] as String?,
            recomendacion: row['recomendacion'] as String?,
            tieneAutorizacion: row['tieneAutorizacion'] as String?,
            estadoAutorizacion: row['estadoAutorizacion'] as String?,
            detalleObservacion: row['detalleObservacion'] as String?,
            rde: row['rde'] as String?,
            fechaRde: row['fechaRde'] as String?,
            parentezco: row['parentezco'] as String?,
            nombreAutorizado: row['nombreAutorizado'] as String?,
            tipoDocAutorizado: row['tipoDocAutorizado'] as String?,
            dniAutorizado: row['dniAutorizado'] as String?,
            autorizadoSexo: row['autorizadoSexo'] as String?,
            telefonoAutorizado: row['telefonoAutorizado'] as String?,
            correoAutorizado: row['correoAutorizado'] as String?,
            prioridad: row['prioridad'] as String?,
            tipoDistrito: row['tipoDistrito'] as String?),
        arguments: [id]);
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Padron',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int cod) async {
    return _queryAdapter.query('DELETE FROM Html WHERE cod = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cod]);
  }

  @override
  Future<int?> BorrarTodo() async {
    return _queryAdapter.query('DELETE FROM Padron',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModel(Padron formDataModel) async {
    await _padronInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}

class _$FormDataModelDaoPadronLogin extends FormDataModelDaoPadronLogin {
  _$FormDataModelDaoPadronLogin(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _padronLoginInsertionAdapter = InsertionAdapter(
            database,
            'PadronLogin',
            (PadronLogin item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'apellidos': item.apellidos,
                  'hogarDepartamento': item.hogarDepartamento
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PadronLogin> _padronLoginInsertionAdapter;

  @override
  Future<List<PadronLogin>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PadronLogin LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => PadronLogin(
            id: row['id'] as int?,
            nombre: row['nombre'] as String?,
            apellidos: row['apellidos'] as String?,
            hogarDepartamento: row['hogarDepartamento'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<PadronLogin>> findAllPadronLogin() async {
    return _queryAdapter.queryList('SELECT * FROM PadronLogin',
        mapper: (Map<String, Object?> row) => PadronLogin(
            id: row['id'] as int?,
            nombre: row['nombre'] as String?,
            apellidos: row['apellidos'] as String?,
            hogarDepartamento: row['hogarDepartamento'] as String?));
  }

  @override
  Future<String?> findAllPadronLoginID(int id) async {
    return _queryAdapter.query(
        'SELECT PadronLogincodigo FROM PadronLogin WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM PadronLogin',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int ID) async {
    return _queryAdapter.query(
        'DELETE FROM PadronLogin WHERE codigoVisita = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [ID]);
  }

  @override
  Future<void> insertFormDataModel(PadronLogin formDataModel) async {
    await _padronLoginInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}
