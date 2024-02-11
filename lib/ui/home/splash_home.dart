import 'dart:async';

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_timer_app/ui/home/home_dashboard.dart';
import 'package:simple_timer_app/utils/colors/Color.dart';
import 'package:flutter/services.dart';
import 'package:simple_timer_app/utils/drawables/svg.dart';

import '../../utils/drawables/images.dart';

class SplashHome extends StatelessWidget {

  late Timer timer;


  @override
  Widget build(BuildContext context) {

    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeDashboard()),
      );
    });
    // Hide system UI overlays (status bar and navigation bar)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              drkblu, // Dark Blue at the top
              litblu, // Light Blue at the bottom
            ],
          ),
        ),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeDashboard()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.indigo[600],
                  borderRadius: BorderRadius.circular(20)),
                    height: 170,
                    width: 170,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                        width: 100,
                        child: Image.asset(dtimelogo),
                  ),
                )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 50,
                    width: 100,
                    child: SvgPicture.asset(splashlogo)),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeDashboard()),
                  );
                },
                  child: Text("Time management without obstacles",style: TextStyle(color: Colors.white),))

            ],
          ),
        ),
      ),
    );
  }
}

