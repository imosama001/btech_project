import 'package:flutter/material.dart';
class HelpAndSupport extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help and Support"),
        backgroundColor: Colors.amber,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child:  Padding(
              padding:  EdgeInsets.all(12.0),
              child: Text("For any Querries you can contact to developers. Our Team has currently 3 developers\n\n1. Mohd Osama Raza - 8418080332 - imosama001@gmail.com \n\nKaushik Biswas - 9306288532 \n\nYogesh Kumar - 6395330678\n",style: TextStyle(
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
