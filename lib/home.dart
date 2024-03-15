import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/create_Note_View.dart';
import 'package:keep_notes/model/my_Note_Model.dart'; // Import the Note class from my_Note_Model.dart
import 'package:keep_notes/note_View.dart';
import 'package:keep_notes/searched_Notes.dart';
import 'package:keep_notes/services/db.dart';
import 'package:keep_notes/side_menu_bar.dart';

String Heading = "Heading";
String text1 =
    "Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note ";
String text2 =
    "Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note NoteNote Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note Note";

bool isLoading = true;
late List<Note> noteList = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();

  //Defining Global Key to open the Drawer:
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  //Creating the list of Notes to Render it in the Staggered View

  @override
  void dispose() {
    // TODO: implement dispose
    //Cleaning up the controller:
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEntry();
    // searchResults("Abhay");
    // getOneNote(3);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAllEntry();
  }

  Note note = Note(
      pin: false,
      isArchive: false,
      title: "Abhay First Note",
      content: "This is first Note created Using the model class",
      createdTime: DateTime.now());

  Future createEntry({Note? note}) async {
    await NotesDataBase.instance.insertEntry(note!);
  }

  Future getAllEntry() async {
    noteList = await NotesDataBase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  Future getOneNote(int id) async {
   Note? newnote = await NotesDataBase.instance.readOneNote(id);
   print(newnote);
  }

  Future getDeleteNote(Note note) async {
    await NotesDataBase.instance.deleteNote(note);
  }

  //Search Functionality code:

 late List<int> searchResultId = [];
 late List<Note?> searchResultsNotes = [];

  void searchResults(String query) async {
    searchResultsNotes.clear();
    final List<int>? resultIds =
    await NotesDataBase.instance.getNoteString(query); //[1,2,3,4,5]
    print("This result id received in home Activity $resultIds");

    if (resultIds != null && resultIds.isNotEmpty) {
      // Use Future.wait to wait for all asynchronous tasks to complete
      await Future.wait(resultIds.map((element) async {
        final Note? newNote = await NotesDataBase.instance.readOneNote(element);
        return newNote;
      })).then((List<Note?> notes) {
        searchResultsNotes.addAll(notes);
        print("List of Notes in Home.dart: ${searchResultsNotes}");

        // Once all notes are added to searchResultsNotes, navigate
        print("Enabeling Navigator.push");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchedNotes(listOfNotes: searchResultsNotes)));
      });
    }
  }


  // void searchResults(String query) async {
  //   searchResultsNotes.clear();
  //   final List<int>? resultIds =
  //       await NotesDataBase.instance.getNoteString(query); //[1,2,3,4,5]
  //   print("This result id received in home Activity $resultIds");
  //
  //   resultIds?.forEach((element)async {
  //     final Note? newNote = await NotesDataBase.instance.readOneNote(element);
  //    searchResultsNotes.add(newNote) ;
  //    print("List of Notes in Home.dart: ${searchResultsNotes}");
  //   });
  //   print(searchResultsNotes);
  //   print("Enabeling Navigator.push");
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchedNotes(listOfNotes: searchResultsNotes)));
  // }



  //
  //   // // print("this is result ids $resultIds");
  //   // List<Note?> SearchResultNotesLocal = [];
  //   // resultIds?.forEach((element) async {
  //   //   final searchNote = await NotesDataBase.instance.readOneNote(element);
  //   //   print("This is result of the getStringQuery $searchNote");
  //   //   // searchResultsNotes.add(searchNote);
  //   //   // SearchResultNotesLocal.add(searchNote);
  //   //   // print("$searchResultsNotes + This is the list of the serachResult");
  //   // });


  @override
  Widget build(BuildContext context) {
    // print(searchResultsNotes);

    //Accessed size of the screen
    var mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bgColor,
        key: _drawerKey,
        drawer: const SideBar(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateNoteView()));
            },
            child: const Icon(Icons.add)),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: mq.width*0.01),
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
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) async {
                                  setState(() {
                                    searchResults(value.toLowerCase());
                                  });


                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SearchedNotes(
                                                listOfNotes: [],
                                              )));

                                },
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
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.settings,
                          //       color: Colors.white.withOpacity(0.5),
                          //       size: 20,
                          //     ))
                          CircleAvatar(backgroundImage: NetworkImage(""),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: mq.height * 0.01),
                  //Without Color Notes:
                  staggeredView1(context, mq),
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

Widget staggeredView1(BuildContext context, Size mq) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.symmetric(horizontal: mq.width * 0.015),
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
          itemCount: noteList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteView(
                              comingNoteObject: noteList[index],
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
                        noteList[index].title,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        noteList[index].content,
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
                      index.isEven ? text1 : text2,
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

Widget listViewNotes(BuildContext context, Size mq) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.015),
      child: Text(
        "Notes List:-",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.5)),
      ),
    ),
    SizedBox(
      height: mq.height * 0.01,
    ),
    Column(
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
                      index.isEven ? text1 : text2,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 13),
                    ),
                  ],
                ),
              );
            })
      ],
    ),
  ]);
}
