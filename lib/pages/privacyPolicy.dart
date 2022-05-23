import 'package:flutter/material.dart';
class PrivacyPolicy extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy and Policy"),
        backgroundColor: Colors.amber,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child:  Padding(
              padding:  EdgeInsets.all(12.0),
              child: Text("""This privacy policy ("policy") will help you understand how [name] ("us", "we", "our") uses and protects the data you provide to us when you visit and use [website] ("website", "service").\nWhat User Data We CollectWhat User Data We Collect-\n\nYour contact information and email address\nYour age \nPersonality Type base on MBTI\n\nWhy we collect these data\n• To better understand your needs.
• To improve our services and products.
• To send you promotional emails containing the information we think you will find
interesting.
• To contact you to fill out surveys and participate in other types of market research.
• To customize our website according to your online behavior and personal preferences.\n\nWe are bound to not disclose your personal details with anyone other than the counselors you chose to consult with . The counselors details will always be available to see for any user for seemless consulting process. the Counselors are also bound to not disclose your information with anyone else for whatsover reason.""",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,


              ),
                textAlign: TextAlign.justify,),
            ),),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:const  Text("Accept and Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
