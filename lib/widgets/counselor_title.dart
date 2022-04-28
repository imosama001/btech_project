import 'package:b_tech_project/pages/counselor_details_page.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class CounselorDetailedTitle extends StatelessWidget {
  const CounselorDetailedTitle({
    Key? key,
    required this.context,
    required this.widget,
    //required this.widget,
    //required this.widget,
  }) : super(key: key);

  final BuildContext context;
  final CounselorDetails widget;
  //final CounselorDetails widget;
  //final CounselorDetails widget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .3,
      color: HexColor('#00C6AD'),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: size.width * .8,
              height: size.height * .28,
              child: const Image(
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitHeight,
                image: AssetImage('images/bg_shape.png'),
              ),
            ),
          ),
          Positioned(
            right: size.width * .08,
            bottom: size.height * .01,
            child: SizedBox(
              height: 250,
              child: AspectRatio(
                aspectRatio: 196 / 285,
                child: Hero(
                  tag: widget.doctor.name,
                  child: const Image(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fitHeight,
                    image: AssetImage('images/mathew.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 15,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 32,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xffFFBB23),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    widget.doctor.rating.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
