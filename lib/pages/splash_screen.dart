import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:b_tech_project/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'images/logo.png',
                width: size.width * 0.8,
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            SizedBox(
              height: size.height * 0.1,
              child: const LoadingIndicator(
                indicatorType: Indicator.ballBeat,
                colors: [kHomePageContainerColor],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
