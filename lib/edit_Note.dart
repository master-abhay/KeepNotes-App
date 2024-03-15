import 'package:flutter/material.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/model/my_Note_Model.dart';
import 'package:keep_notes/services/db.dart';

import 'home.dart';

Future updateNote({Note? note}) async {
  await NotesDataBase.instance.updateNote(note!);
}

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.comingObject});

  final Note? comingObject;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late String newNoteTitle;
  late String newNoteContent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.newNoteTitle = widget.comingObject!.title as String;
    this.newNoteContent = widget.comingObject!.content as String;
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {

          Note newNote = Note(
              pin: false,
              isArchive: false,
              title: newNoteTitle,
              content: newNoteContent,
              createdTime: widget.comingObject!.createdTime,
              id: widget.comingObject!.id);
          updateNote(note: newNote);


      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          leading: BackButton(
            color: Colors.white.withOpacity(0.5),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Note newNote = Note(
                      pin: false,
                      isArchive: false,
                      title: newNoteTitle,
                      content: newNoteContent,
                      createdTime: widget.comingObject!.createdTime,
                      id: widget.comingObject!.id);
                  updateNote(note: newNote);
                  print("Run Success");
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
              TextFormField(
                cursorColor: Colors.white.withOpacity(0.69),
                initialValue: newNoteTitle,
                onChanged: (value) {
                  newNoteTitle = value;
                },
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
                child: TextFormField(
                  initialValue: newNoteContent,
                  onChanged: (value) {
                    newNoteContent = value;
                  },
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
      ),
    );
  }
}
