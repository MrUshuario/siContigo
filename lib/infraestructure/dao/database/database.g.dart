// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
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

  FormDataModelDaoHTML? _formDataModelDaoHTMLInstance;

  FormDataModelDaoFormulario? _formDataModelDaoFormularioInstance;

  FormDataModelDaoRespuesta? _formDataModelDaoRespuestaInstance;

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
            'CREATE TABLE IF NOT EXISTS `Html` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `htmlcodigo` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Formulario` (`cod` INTEGER PRIMARY KEY AUTOINCREMENT, `pregunta` TEXT, `tipoOpcion` TEXT, `tipoRepuesta` INTEGER, `id` INTEGER, `idformato` INTEGER, `texto` TEXT, `titulo` TEXT, `idseccion` INTEGER, `descripcion` TEXT, `id_tipo_respuesta` INTEGER, `id_seccion` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Respuesta` (`cod` INTEGER PRIMARY KEY AUTOINCREMENT, `idformato` INTEGER, `id_usuario` INTEGER, `fecha` TEXT, `respuestas` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FormDataModelDaoHTML get formDataModelDaoHTML {
    return _formDataModelDaoHTMLInstance ??=
        _$FormDataModelDaoHTML(database, changeListener);
  }

  @override
  FormDataModelDaoFormulario get formDataModelDaoFormulario {
    return _formDataModelDaoFormularioInstance ??=
        _$FormDataModelDaoFormulario(database, changeListener);
  }

  @override
  FormDataModelDaoRespuesta get formDataModelDaoRespuesta {
    return _formDataModelDaoRespuestaInstance ??=
        _$FormDataModelDaoRespuesta(database, changeListener);
  }
}

class _$FormDataModelDaoHTML extends FormDataModelDaoHTML {
  _$FormDataModelDaoHTML(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _htmlInsertionAdapter = InsertionAdapter(
            database,
            'Html',
            (Html item) => <String, Object?>{
                  'id': item.id,
                  'htmlcodigo': item.htmlcodigo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Html> _htmlInsertionAdapter;

  @override
  Future<List<Html>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Html LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Html(
            id: row['id'] as int?, htmlcodigo: row['htmlcodigo'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<Html>> findAllHtml() async {
    return _queryAdapter.queryList('SELECT * FROM Html',
        mapper: (Map<String, Object?> row) => Html(
            id: row['id'] as int?, htmlcodigo: row['htmlcodigo'] as String?));
  }

  @override
  Future<String?> findAllHtmlID(int id) async {
    return _queryAdapter.query('SELECT htmlcodigo FROM Html WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Html',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int ID) async {
    return _queryAdapter.query('DELETE FROM Html WHERE codigoVisita = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [ID]);
  }

  @override
  Future<void> insertFormDataModel(Html formDataModel) async {
    await _htmlInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
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

class _$FormDataModelDaoRespuesta extends FormDataModelDaoRespuesta {
  _$FormDataModelDaoRespuesta(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _respuestaInsertionAdapter = InsertionAdapter(
            database,
            'Respuesta',
            (Respuesta item) => <String, Object?>{
                  'cod': item.cod,
                  'idformato': item.idformato,
                  'id_usuario': item.id_usuario,
                  'fecha': item.fecha,
                  'respuestas': item.respuestas
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Respuesta> _respuestaInsertionAdapter;

  @override
  Future<List<Respuesta>> findFormDataModel(
    int offset,
    int perPage,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Respuesta LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => Respuesta(
            cod: row['cod'] as int?,
            idformato: row['idformato'] as int?,
            id_usuario: row['id_usuario'] as int?,
            fecha: row['fecha'] as String?,
            respuestas: row['respuestas'] as String?),
        arguments: [offset, perPage]);
  }

  @override
  Future<List<Respuesta>> findAllRespuesta() async {
    return _queryAdapter.queryList('SELECT * FROM Respuesta',
        mapper: (Map<String, Object?> row) => Respuesta(
            cod: row['cod'] as int?,
            idformato: row['idformato'] as int?,
            id_usuario: row['id_usuario'] as int?,
            fecha: row['fecha'] as String?,
            respuestas: row['respuestas'] as String?));
  }

  @override
  Future<String?> findAllRespuestaID(int cod) async {
    return _queryAdapter.query(
        'SELECT Respuestacodigo FROM Respuesta WHERE cod = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [cod]);
  }

  @override
  Future<int?> totalFormDataModels() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Respuesta',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> BorrarFormDataModels(int cod) async {
    return _queryAdapter.query('DELETE FROM Respuesta WHERE cod = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [cod]);
  }

  @override
  Future<int?> BorrarTodo() async {
    return _queryAdapter.query('DELETE FROM Formulario',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertFormDataModel(Respuesta formDataModel) async {
    await _respuestaInsertionAdapter.insert(
        formDataModel, OnConflictStrategy.replace);
  }
}
