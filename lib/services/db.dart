import 'package:keep_notes/model/my_Note_Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDataBase {
  static final NotesDataBase instance = NotesDataBase._init();
  static Database? _database;

  NotesDataBase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB("Notes.db");
    return _database;
  }

  Future<Database?> _initializeDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path,
        version: 3, onCreate: _createDB, onUpgrade: _onUpgradeDB);
  }

  Future _createDB(Database db, int version) async {
    try {
      const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      const pinType = 'BOOLEAN NOT NULL';
      const textType = 'TEXT NOT NULL';
      await db.execute('''CREATE TABLE Notes 
        (
        ${NotesImportantNames.id} $idType ,
        ${NotesImportantNames.pin} $pinType,
        ${NotesImportantNames.title} $textType ,
        ${NotesImportantNames.content} $textType,
        ${NotesImportantNames.createdTime} $textType
        )''');
    } catch (error) {
      print("Error in Creating DataBase $error");
      print("Error failed to create DataBase");
    }
  }
  Future _onUpgradeDB(Database db,int oldVersion, int version) async{
    if (oldVersion < 3) {
      // If upgrading from version 1 to 2, add the isArchive column
      await db.execute('''
        ALTER TABLE ${NotesImportantNames.tableName}
        ADD COLUMN ${NotesImportantNames.isArchive} INTEGER DEFAULT 0
      ''');
    }
  }



  Future<Note?> insertEntry(Note note) async {
    try {
      final db = await instance.database;
      final id = await db!.insert(NotesImportantNames.tableName, note.toJson());
      print("Test data inserted successfully");
      return note.copy(id: id);
    } catch (e) {
      print("Error while inserting test data: $e");
      return note;
    }
  }

  Future<String?> updateNote(Note note) async {
    final db = await instance.database;
    final queryResult = await db!.update(
        NotesImportantNames.tableName, note.toJson(),
        where: 'id = ?', whereArgs: [note.id]);
    print(queryResult);
    return "Success";
  }

  Future<String?> pinNote(Note? note) async {
    final db = await instance.database;
    final queryResult = await db!.update(NotesImportantNames.tableName,
        {NotesImportantNames.pin: !note!.pin ? 1 : 0},
        where: 'id = ?', whereArgs: [note.id]);
    print(queryResult);
    return "Success";
  }

  Future<String?> isArchiveNote(Note? note) async {
    try {
      final db = await instance.database;
      final queryResult = await db!.update(NotesImportantNames.tableName,
          {NotesImportantNames.isArchive: !note!.isArchive ? 1 : 0},
          where: 'id = ?', whereArgs: [note.id]);
      print(queryResult);
      return "Success";
    } catch (error) {
      print("Error occurred: $error");
      return "Error: Failed to archive note.";
    }
  }

  Future<String?> deleteNote(Note? note) async {
    final db = await instance.database;
    final queryResult = await db!.delete(NotesImportantNames.tableName,
        where: '${NotesImportantNames.id} = ?', whereArgs: [note!.id]);
    print(queryResult);
    return "Success";
  }

  Future<List<Note>> readAllNotes() async {
    try {
      final db = await instance.database;
      final orderBy = '${NotesImportantNames.createdTime} DESC';
      final queryResult =
          await db!.query(NotesImportantNames.tableName, orderBy: orderBy);
      print(queryResult);
      return queryResult
          .map((e) => Note.fromJson(e))
          .whereType<Note>()
          .toList();
    } catch (e) {
      // Handle any errors that occur during the database query
      print('Error reading notes: $e');
      return []; // or throw an exception
    }
  }

  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;
    final queryResult = await db!.query(NotesImportantNames.tableName,
        columns: NotesImportantNames.value, where: 'id = ?', whereArgs: [id]);
    print(queryResult);

    if (queryResult.isNotEmpty) {
      return Note.fromJson(queryResult.last);
    } else {
      return null;
    }
  }

  Future _closeDB() async {
    await _database?.close();
  }

  // Future<List<int>?> getNoteString(String text) async {
  //   final db = await instance.database;
  //   final result = await db!.query(NotesImportantNames.tableName);
  //   print("This is all Notes Returned : $result");
  //   print("In DB getNoteString");
  //   List<int> resultIds = [];
  //   print("after the resultIds List");
  //   result.forEach((element) {
  //     if (element[NotesImportantNames.title]
  //             .toString()
  //             .toLowerCase()
  //             .contains(text.toString().toLowerCase()) ||
  //         element[NotesImportantNames.content]
  //             .toString()
  //             .toLowerCase()
  //             .contains(text.toString().toLowerCase())) {
  //       resultIds.add(element[NotesImportantNames.id] as int);
  //       print('in for each loop');
  //     }
  //   });
  //   print(resultIds);
  //   return resultIds;
  // }

  Future<List<int>?> getNoteString(String text) async {
    try {
      final db = await instance.database;
      final result = await db!.query(NotesImportantNames.tableName);

      print("All Notes Returned: $result");

      List<int> resultIds = [];

      print("Iterating through results...");

      result.forEach((element) {
        String title =
            element[NotesImportantNames.title].toString().toLowerCase();
        String content =
            element[NotesImportantNames.content].toString().toLowerCase();

        if (title.contains(text.toLowerCase()) ||
            content.contains(text.toLowerCase())) {
          resultIds.add(element[NotesImportantNames.id] as int);
          print(
              'Note with ID ${element[NotesImportantNames.id]} added to result.');
        }
      });

      print("Result IDs: $resultIds");

      return resultIds;
    } catch (e) {
      print("Error in getNoteString: $e");
      return null;
    }
  }
}
