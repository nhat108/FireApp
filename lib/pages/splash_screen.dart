import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SlpashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SlpashScreen>{
    startTime()async{
      var _duration=Duration(seconds: 1);
      return Timer(_duration, navigationPage);
    }
    void navigationPage(){
      Navigator.of(context).pushReplacementNamed('/RootPage');
    }
    @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  SvgPicture.asset('assets/assets/fire.svg',width: 200,height: 200,),
      ),
    );
  }
}