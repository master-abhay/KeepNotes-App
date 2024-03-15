import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/create_Note_View.dart';
import 'package:keep_notes/model/my_Note_Model.dart'; // Import the Note class from my_Note_Model.dart
import 'package:keep_notes/note_View.dart';
import 'package:keep_notes/searched_Notes.dart';
import 'package:keep_notes/services/db.dart';
import 'package:keep_notes/side_menu_bar.dart';

import 'model/my_Note_Model.dart';

class SearchedNotes extends StatefulWidget {
  const SearchedNotes({super.key, required this.listOfNotes});

  final List<Note?> listOfNotes;

  @override
  State<SearchedNotes> createState() => _SearchedNotesState();
}

bool isLoading = false;
late List<Note?> listOfNotes = [];

class _SearchedNotesState extends State<SearchedNotes> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("In SearchedNotes: ${widget.listOfNotes}");
    listOfNotes = widget.listOfNotes;
    setState(() {
      isLoading = !isLoading;
    });
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
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
        child: Column(
          children: [
            staggeredView1(context: context,mq: mq,)
          ],
        ),
      ),
    );
  }
}

Widget staggeredView1({BuildContext? context, Size? mq}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.symmetric(horizontal: mq!.width * 0.015),
          child: Text(
            "Notes:-",
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          )),
      SizedBox(
        height: mq.height * 0.01,
      ),
      MasonryGridView.builder(
          mainAxisSpacing: 3,
          crossAxisSpacing: 2,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: listOfNotes.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteView(
                              comingNoteObject: listOfNotes[index],
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  // color: Colors.grey.withOpacity(0.1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.20)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listOfNotes[index]!.title,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        listOfNotes[index]!.content,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
    ],
  );
}
