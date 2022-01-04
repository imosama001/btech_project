import 'package:flutter/material.dart';
import '../colors.dart';

class DetailCell extends StatelessWidget {
  final String title;
  final String subTitle;

  const DetailCell({
    required this.title,
    required this.subTitle,
  });

  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: HexColor('#EDFDFA'),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 61,
              height: 31,
              decoration: BoxDecoration(
                color: HexColor('#E1F7F4'),
                borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: HexColor('#00C6AD'),
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: HexColor('#696969'),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
