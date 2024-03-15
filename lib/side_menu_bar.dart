import 'package:flutter/material.dart';
import 'package:keep_notes/archived_Notes.dart';
import 'package:keep_notes/colors.dart';
import 'package:keep_notes/home.dart';
import 'package:keep_notes/settings.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: bgColor,
      child: SafeArea(
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          margin: EdgeInsets.only(top: mq.height*0.02,left: mq.width*0.02,right: mq.width*0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         const Text(
                "Google Notes",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              SectionOne(context),
              SectionTwo(context),
              SectionThree(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget SectionOne(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
    // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
    child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
        },
        style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.yellow.withOpacity(0.3)),
            backgroundColor:
                MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.5)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))))),
        child: Row(
          children: [
            const Icon(
              Icons.lightbulb,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "Notes",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
  );
}

Widget SectionTwo(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
    // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
    child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchivedNotes()));
        },
        style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.yellow.withOpacity(0.3)),
            // backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.5)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))))),
        child: Row(
          children: [
            const Icon(
              Icons.archive_outlined,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "Archived",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            )
          ],
        )),
  );
}

Widget SectionThree(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
    // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
    child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
        },
        style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.yellow.withOpacity(0.3)),
            // backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.5)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))))),
        child: Row(
          children: [
            const Icon(
              Icons.settings_outlined,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "Settings",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            )
          ],
        )),
  );
}
