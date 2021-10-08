import 'dart:async';

import 'package:flutter/material.dart';
import 'package:last_fm_challenge/1_navigation/route_names.dart';
import 'package:last_fm_challenge/shared_widgets/image_widget.dart';
import 'package:last_fm_challenge/utilities/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int _splashDurationInSeconds = 2;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'appLogo',
          child: ImageWidget(
            ImageUrls.logo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }

  Timer startTime() {
    var _duration = Duration(seconds: _splashDurationInSeconds);
    return Timer(_duration, goToNextScreen);
  }

  void goToNextScreen() async {
    Navigator.pushReplacementNamed(
      context,
      RouteNames.main,
    );
  }
}
