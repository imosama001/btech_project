import '/rescue_page.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'model/rescue.dart';

void main() => runApp(const a1());

// ignore: camel_case_types
class a1 extends StatelessWidget {
  const a1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.cyan, // Yellow
              height: size.height * .3,
              width: size.width,
              child: const Center(
                  child: Text(
                "Rescue Session",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: const [
                  Text(
                    "Had a rough day",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            rowsView(
                RescueData(
                  header: "Stress & Overwhelm",
                  status:
                      "Hey there, We all experience stress from time to time",
                  background: Colors.cyan,
                  status2:
                      "Sometimes it gets too much to handle , and thats alright. This happens to the best of us",
                  status3: "Today, we will help you relax and destress",
                  bgImage: "images/stress.png",
                ),
                RescueData(
                    header: 'Proscrastination',
                    background: Colors.blue,
                    bgImage: "images/proscat.jpg",
                    status: 'Hello! How are you feeling today?',
                    status2: 'You are feeling this way because of',
                    status3:
                        'Family. Friends. Relationships. Work. School. Exercise. Food and Drinks. Travel. Music. Hobbioes. Weather. Finance '),
                context),
            rowsView(
                RescueData(
                    header: 'Feeling Lost',
                    background: Colors.red,
                    bgImage: "images/lost.png",
                    status: 'Hello! How are you feeling today?',
                    status2: 'You are feeling this way because of',
                    status3:
                        'Family. Friends. Relationships. Work. School. Exercise. Food and Drinks. Travel. Music. Hobbioes. Weather. Finance '),
                RescueData(
                    header: 'Anger & Frustration',
                    background: Colors.yellow,
                    bgImage: "images/anger.png",
                    status:
                        'Yoy Might be feeling a little upset right now, and thats okay. Anger is a very common emotion',
                    status2:
                        'We all feel it, and we all express it in different ways. Sometimes however, in a way that might not be right ',
                    status3:
                        'Today we are going to help you release your emotions, but in a healthy way'),
                context),
            rowsView(
                RescueData(
                    header: 'Lack of Motivation',
                    background: Colors.blue,
                    bgImage: "images/motivation.png",
                    status: 'Hello! How are you feeling today?',
                    status2: 'You are feeling this way because of',
                    status3:
                        'Family. Friends. Relationships. Work. School. Exercise. Food and Drinks. Travel. Music. Hobbioes. Weather. Finance '),
                RescueData(
                    header: 'Insecurity',
                    background: Colors.blue,
                    bgImage: "images/insecurity.jpg",
                    status:
                        'Yoy Might be feeling a little upset right now, and thats okay. Anger is a very common emotion',
                    status2:
                        'We all feel it, and we all express it in different ways. Sometimes however, in a way that might not be right ',
                    status3:
                        'Today we are going to help you release your emotions, but in a healthy way'),
                context),
            rowsView(
                RescueData(
                    header: "Sleep",
                    background: Colors.blue,
                    bgImage: "images/sleep.jpg",
                    status: 'Hello! How are you feeling today?',
                    status2: 'You are feeling this way because of',
                    status3:
                        'Family. Friends. Relationships. Work. School. Exercise. Food and Drinks. Travel. Music. Hobbioes. Weather. Finance '),
                RescueData(
                    header: "Low Mood",
                    background: Colors.blue,
                    bgImage: "images/low.jpg",
                    status:
                        'Hey You! We have all been there. When  you wake up and it just dose not feel like it is your day',
                    status2:
                        'Moments like this can be hard to deal with on your own, but it is alright',
                    status3:
                        'Toady we are going to help you pick yourself up from this slump.'),
                context),
            rowsView(
                RescueData(
                    header: "Critisism",
                    background: Colors.blue,
                    bgImage: "images/criti.jpg",
                    status:
                        'If Someone just gave you harsh feedback, you might be feeling a little upset right now',
                    status2:
                        'But that is okay, taking criticism is never easy.',
                    status3:
                        'We are going to help you feel a little better by processing the feedback in a healthy way'),
                RescueData(
                    header: "Disappointment",
                    background: Colors.blue,
                    bgImage: "images/disap.jpg",
                    status: 'Hello! How are you feeling today?',
                    status2: 'You are feeling this way because of',
                    status3:
                        'Family. Friends. Relationships. Work. School. Exercise. Food and Drinks. Travel. Music. Hobbioes. Weather. Finance '),
                context),
            Container(
              color: Colors.white, // Yellow
              height: 50.0,
              width: 40.0,
              child: const Center(),
            ),
          ],
        ),
      ),
    )));
  }

  Widget rowsView(RescueData first, RescueData second, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        storyView(first, context),
        storyView(second, context),
      ],
    );
  }

  Widget storyView(RescueData res, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                // ignore: todo
                //TODO:Here make the pages such that both TTS page and Rescue page contents comes together
                builder: (context) => RescuePage(
                      data: res,
                      story: const [],
                    )
                // builder: (context) => TTS()
                ));
      },
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Image(
            image: AssetImage(res.bgImage),
            width: 160,
            height: 100,
            fit: BoxFit.contain,
          ),
          Text(
            res.header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
