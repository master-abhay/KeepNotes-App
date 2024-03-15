import 'package:flutter/material.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/home.dart';
import 'package:keep_notes/services/db.dart';
import 'edit_Note.dart';
import 'package:keep_notes/model/my_Note_Model.dart';

String Heading = "Heading";
String text =
    "Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note ";
String text1 =
    "Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note NoteNote Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note";

class NoteView extends StatefulWidget {
  const NoteView({super.key,required this.comingNoteObject});

  final Note? comingNoteObject;

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  print("Inside note view pin:................ ${widget.comingNoteObject!.pin}");
  print("Inside note view pin:................ ${widget.comingNoteObject!.isArchive}");

  }

  @override
  Widget build(BuildContext context) {



  Size mq = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: bgColor,
    appBar: AppBar(
      leading: BackButton(
        color: Colors.white.withOpacity(0.5),
      ),
      backgroundColor: bgColor,
      elevation: 0.0,
      actions: [
        IconButton(
            onPressed: () async{

           await NotesDataBase.instance.pinNote(widget.comingNoteObject);

           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

            },
            splashRadius: 17,
            splashColor: Colors.white.withOpacity(0.30),
            icon: Icon(
              widget.comingNoteObject!.pin ? Icons.push_pin_sharp : Icons.push_pin_outlined,
              color: Colors.white.withOpacity(0.5),
            )),
        IconButton(
            onPressed: () async{
              await NotesDataBase.instance.isArchiveNote(widget.comingNoteObject);
              print("In the Archive button");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

            },
            splashRadius: 17,
            splashColor: Colors.white.withOpacity(0.30),
            icon: Icon(
             widget.comingNoteObject!.isArchive ? Icons.archive : Icons.archive_outlined,
              color: Colors.white.withOpacity(0.5),
            )),
        IconButton(
            onPressed: ()async {
              await NotesDataBase.instance.deleteNote(widget.comingNoteObject);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            splashRadius: 17,
            splashColor: Colors.white.withOpacity(0.30),
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Colors.white.withOpacity(0.5),
            )),
        //EditNoteIcon:
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditNote(comingObject: widget.comingNoteObject,)));
            },
            splashRadius: 17,
            splashColor: Colors.white.withOpacity(0.30),
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.white.withOpacity(0.5),
            )),

      ],
    ),
    body: Container(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.017),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.comingNoteObject!.title,
            style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          Text(
            widget.comingNoteObject!.content,
            style:
            TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
          ),
        ],
      ),
    ),
  );
}
}

