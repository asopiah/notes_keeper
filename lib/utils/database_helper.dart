import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';

class DatabaseHelper {
  /// Singleton DatabaseHelper i.e _databaseHelper will only be initialized once throughout the life-cycle of the application
  static DatabaseHelper _databaseHelper;
  ///signleton Database
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';
/// Named constructor to create instance of DatabaseHelper
  DatabaseHelper._createInstance();
  factory DatabaseHelper() { /// factory constructor
    if(_databaseHelper==null) {
      /// initialized the Object and calling a named constructor(_createInstance). This only executed once, singleton object
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }
  Future<Database>initializeDatabase() async{
    /// get the directory path for both Android and iOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    /// open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDB);
    return notesDatabase;
  }
  void _createDB(Database db, int newVersion) async{
    await db.execute('create table $noteTable ($colId integer primary key autoincrement, $colTitle text, $colDescription text, $colPriority integer, $colDate text)');
  }

  /// Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

   ///var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  /// Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  /// Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  /// Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  /// Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
