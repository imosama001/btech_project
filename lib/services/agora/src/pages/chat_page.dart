import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:b_tech_project/services/agora/call.dart';
import 'package:b_tech_project/services/agora/src/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      //color: Colors.red,
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.video_call_rounded),
          onPressed: () async {
            await Permission.camera.request();
            await Permission.microphone.request();

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CallPage(
                  channelName: 'test',
                  role: ClientRole.Broadcaster,
                  token: Token),
            ));
          },
        ),
      ),
    );
  }
}
