import 'package:b_tech_project/repository/user_repository.dart';
import 'package:b_tech_project/utilites/doctor_parameter.dart';
import 'package:b_tech_project/widgets/icons.dart';
import 'package:b_tech_project/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HDCell extends StatefulWidget {
  final Doctor doctor;
  final Function onTap;

  const HDCell({
    //Key key,
    required this.doctor,
    required this.onTap,
  });

  @override
  State<HDCell> createState() => _HDCellState();
}

class _HDCellState extends State<HDCell> {
  UserRepository? _conselorList;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // _conselorList = Provider.of<UserRepository>(context);
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        width: size.width * .7,
        height: size.height * .3,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: HexColor('#00C6AD'),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 16,
              right: 16,
              child: SizedBox(
                width: 162,
                height: 139,
                child: Image(
                  image: AssetImage('images/bg_shape.png'),
                ),
              ),
            ),
            Positioned(
              top: 32,
              left: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${widget.doctor.name}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Text(
                  //   _conselorList!  ['name'],
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 22,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  // Text(
                  //   widget.doctor.lastName,
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 22,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.doctor.speciality + ' Specialist',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: 77,
                height: 54,
                decoration: BoxDecoration(
                  color: HexColor('#00A994'),
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(32)),
                ),
                child: const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 0,
              child: SizedBox(
                width: 120,
                height: 173,
                child: Hero(
                  tag: widget.doctor.name,
                  child: Image(
                    filterQuality: FilterQuality.high,
                    //image: AssetImage('images/mathew.png'),
                    image: widget.doctor.image.image,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
