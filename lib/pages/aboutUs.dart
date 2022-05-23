import 'package:flutter/material.dart';
class AboutUs extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Colors.amber,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child:  Padding(
              padding:  EdgeInsets.all(12.0),
              child: Text("We are a group of young developers\n\n1. Mohd Osama Raza - 8418080332 - imosama001@gmail.com \n\nKaushik Biswas - 9306288532 \n\nYogesh Kumar - 6395330678\n\nOur main objective is to provide Psychiatrists counseling services in India an spread awareness about the personality types.\nWe provide certified counselors in India whom you can book at given slots and have a chat with them for betterment of your mental health and personality.\nWith proper awareness about a person's personality anyone can boost in there career as well as there relationship by understanding each other more deeply and truly.",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,


              ),
                textAlign: TextAlign.justify,),
            ),),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:const  Text("Continue to App"),
            ),
          ],
        ),
      ),
    );
  }
}
