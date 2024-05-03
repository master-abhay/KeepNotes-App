import 'package:cloud_firestore/cloud_firestore.dart';

class _ImpNames {
  static const String TITLE = "title";
  static const String CONTENET = "content";
}

class MyNote {
  String? title;
  String? content;

  MyNote({required this.title, required this.content});

  MyNote.fromJson(Map<String, dynamic> Json) {
    MyNote(title: Json['title'], content: Json['content']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[_ImpNames.TITLE] = title;
    data[_ImpNames.CONTENET] = content;
    return data;
  }
}
