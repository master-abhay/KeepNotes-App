
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/create_Note_View.dart';
import 'package:keep_notes/note_View.dart';
import 'package:keep_notes/side_menu_bar.dart';

String Heading = "Heading";
String Note =
    "Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note ";
String Note1 =
    "Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note NoteNote Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note";

class ArchivedNotes extends StatefulWidget {
  const ArchivedNotes({super.key});

  @override
  State<ArchivedNotes> createState() => _ArchivedNotesState();
}

class _ArchivedNotesState extends State<ArchivedNotes> {
  final searchController = TextEditingController();

  //Defining Global Key to open the Drawer:
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    //Cleaning up the controller:
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Accessed size of the screen
    var mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bgColor,
        key: _drawerKey,
        drawer: const SideBar(),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNoteView()));
            },
            child: const  Icon(Icons.add)
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: mq.width * 0.017),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // MainContainer of TopBar
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: mq.width * 0.005,
                        vertical: mq.height * 0.005),
                    height: mq.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.30),
                            spreadRadius: 2,
                            blurRadius: 3)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: Colors.white)
                    ),
                    child: Row(
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.green)),
                            child: IconButton(
                              onPressed: () {
                                _drawerKey.currentState!.openDrawer();
                              },
                              icon: const Icon(Icons.menu),
                              iconSize: 25,
                              color: Colors.white.withOpacity(0.50),
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 7),
                            child: TextField(
                              controller: searchController,
                              cursorColor: Colors.white.withOpacity(0.5),
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.35),
                                  fontSize: 13,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "search note...",
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.50),
                                      fontSize: 13)),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.white.withOpacity(0.1)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(50.0)))),
                            child: Icon(
                              Icons.grid_view_rounded,
                              color: Colors.white.withOpacity(0.5),
                              size: 20,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white.withOpacity(0.5),
                              size: 20,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  //coloured Notes:
                  staggeredView2(context, mq),
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  //ListView of Notes:
                  listViewNotes(context, mq)
                ],
              ),
            ),
          ),
        ));
  }
}



Widget staggeredView2(BuildContext context, Size mq) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.symmetric(horizontal: mq.width * 0.015),
          child: Text(
            "Coloured Notes:-",
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
          itemCount: 50,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                color: index.isEven ? Colors.green : Colors.orangeAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Heading,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      index.isEven ? Note : Note1,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
    ],
  );
}

Widget listViewNotes(BuildContext context,Size mq) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: mq.width*0.015),
          child: Text("Notes List:-",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.5)),),
        ),
        SizedBox(
          height: mq.height * 0.01,
        )
        ,Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,

                itemBuilder: (BuildContext context, int index) {

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    // color: Colors.grey.withOpacity(0.1),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.20)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Heading,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          index.isEven ? Note : Note1,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7), fontSize: 13),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),]
  );
}
