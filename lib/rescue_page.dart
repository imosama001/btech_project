import 'package:b_tech_project/model/tts.dart';

import '/model/rescue.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:story_view/story_view.dart';

// ignore: must_be_immutable
class RescuePage extends StatefulWidget {
  RescueData data;

  // ignore: prefer_typing_uninitialized_variables
  var story;
  RescuePage({Key? key, required this.data, required this.story})
      : super(key: key);

  static get controller => null;
  @override
  State<RescuePage> createState() => _RescuePageState();
}

class StoryPageView {}

class _RescuePageState extends State<RescuePage> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Container(
                color: widget.data.background, //cyan
                height: 300.0,
                width: 400.0,

                child: Center(
                    child: Text(
                  widget.data.header,
                  style: const TextStyle(color: Colors.white, fontSize: 35),
                )),
              ),
            ),
            Column(
              children: [
                Center(
                  child: Image.asset(widget.data.bgImage),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                widget.data.status,
                style: const TextStyle(color: Colors.green, fontSize: 30),
              )),
            ),
            Column(
              children: const [],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  widget.data.status2,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              color: Colors.redAccent, // Yellow
              height: 170.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  widget.data.status3,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                child: TextButton(
                  child: const Text("Go To Podcast"),
                  //const SizedBox(height: 100,),
                  // color: Colors.blue,
                  onPressed: () {
                    String speakdata = widget.data.status +
                        '/n' +
                        widget.data.status2 +
                        '/n' +
                        widget.data.status;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TTS(speakdata: speakdata)));
                  },
                ),
                color: Colors.cyan, // Yellow
                height: 50.0, width: 500,
              ),
            ),
          ],
        ),
      ),
    )));
  }

  // ignore: non_constant_identifier_names
  podcast_page() {}
}
