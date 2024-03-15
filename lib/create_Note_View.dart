import 'package:flutter/material.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/model/my_Note_Model.dart';
import 'package:keep_notes/services/db.dart';

import 'home.dart';

Future createNoteViewEntry({Note? note}) async {
  await NotesDataBase.instance.insertEntry(note!);
}

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {

  SearchController _textController1 = SearchController();
  SearchController _textController2 = SearchController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController1.dispose();
    _textController2.dispose();
  }
  @override
  Widget build(BuildContext context) {


    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: BackButton(
          color: Colors.white.withOpacity(0.5),
        ),
        actions: [
          IconButton(
              onPressed: () {
                final newNote = Note(
                    pin: false,
                    isArchive: false,
                    title: _textController1.text,
                    content: _textController2.text,
                    createdTime: DateTime.now());
                createNoteViewEntry(note: newNote);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              splashRadius: 17,
              splashColor: Colors.white.withOpacity(0.30),
              icon: Icon(
                Icons.save_outlined,
                color: Colors.white.withOpacity(0.5),
              )),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: mq.width * 0.017),
        padding: EdgeInsets.symmetric(horizontal: mq.width * 0.017),
        child: Column(
          children: [
            TextField(
              controller: _textController1,
              cursorColor: Colors.white.withOpacity(0.69),
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.017),
              height: 300,
              child: TextField(
                controller: _textController2,
                cursorColor: Colors.white,
                keyboardType: TextInputType.multiline,
                minLines: 50,
                maxLines: null,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.80), fontSize: 17),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Note",
                    hintStyle: TextStyle(
                        fontSize: 17, color: Colors.white.withOpacity(0.50))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
