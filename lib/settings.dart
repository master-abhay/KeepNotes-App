import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_notes/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //Sync initial value
  bool value = true;
  @override
  Widget build(BuildContext context) {

    //Accessing size of the context screen
    Size mq = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: BackButton(
          color: Colors.white.withOpacity(0.5),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white.withOpacity(0.80),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: mq.width*0.018),
        padding: EdgeInsets.symmetric(horizontal: mq.width*0.018),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sync",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 16),),
                Transform.scale(
                  scale: 0.7,
                  child: Switch.adaptive(

                      value: value,
                      onChanged: (switchValue) {
                        setState(() {
                          this.value = switchValue;
                        });

                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
