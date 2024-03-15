class NotesImportantNames {
  static const String id = "id";
  static const String pin = "pin";
  static const String isArchive = "isArchive";
  static const String title = "title";
  static const String content = "content";
  static const String createdTime = "createdTime";
  static const String tableName = "Notes";

  static const List<String> value = [
    id,
    pin,
    isArchive,
    title,
    content,
    createdTime
  ];
}

class Note {
  final int? id;
  final bool pin;
  final bool isArchive;
  final String title;
  final String content;
  final DateTime? createdTime;

  const Note(
      {this.id,
      required this.pin,
      required this.isArchive,
      required this.title,
      required this.content,
      required this.createdTime});

  //constant copy function
  // It creates a new Note object with the same values as the current object,
  // except for the fields that are explicitly provided as parameters.
  // If a parameter is not provided (i.e., it's null), the corresponding field from the current object is used.
  Note copy(
      {int? id,
      bool? pin,
      bool? isArchive,
      String? title,
      String? content,
      DateTime? createdTime}) {
    return Note(
        id: id ?? this.id,
        pin: pin ?? this.pin,
        isArchive: isArchive ?? this.isArchive,
        title: title ?? this.title,
        content: content ?? this.content,
        createdTime: createdTime ?? this.createdTime);
  }

// Method to convert JSON to object
  static Note? fromJson(Map<String, Object?> json) {
    try {
      return Note(
          id: json[NotesImportantNames.id] as int,
          pin: json[NotesImportantNames.pin] == 1,
          isArchive: json[NotesImportantNames.isArchive] == 1,
          title: json[NotesImportantNames.title] as String,
          content: json[NotesImportantNames.content] as String,
          createdTime:
              DateTime.parse(json[NotesImportantNames.createdTime] as String));
    } catch (element) {
      throw Exception(element);
    }
  }

  // Method to convert object to JSON
  Map<String, Object?> toJson() {
    try {
      return {
        NotesImportantNames.id: id,
        //Here NotesImportantNames.id  = "id" which is actually a string that what we need.
        // NotesImportantNames.pin: pin != null ? (pin ? 1 : 0) : null,
        NotesImportantNames.pin: 0,
        NotesImportantNames.title: title,
        NotesImportantNames.content: content,
        NotesImportantNames.createdTime: createdTime?.toIso8601String(),
      };
    } catch (element) {
      throw Exception(element);
    }
  }
}
