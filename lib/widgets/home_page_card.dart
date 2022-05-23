import 'package:b_tech_project/colors.dart';
import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  HomePageCard(
      {required this.image,
      required this.cardString,
      required this.onButtonPressed,
      required this.cardDescriptionText});
  final Image image;
  final String cardString;
  final String cardDescriptionText;
  final Function()? onButtonPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.29,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            color: kHomePageContainerColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(3, 3))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.width * .02,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .038,
                        vertical: size.width * .02),
                    child: SizedBox(
                      width: size.width * .4,
                      child: Text(
                        cardDescriptionText,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        height: size.height * 0.1,
                        //width: size.width * .3,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: image),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onButtonPressed,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius: 2, offset: Offset(1, 2))
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    cardString,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
