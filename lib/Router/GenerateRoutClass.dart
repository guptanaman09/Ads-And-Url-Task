import 'package:adsandurl/Screens/MainScreen.dart';
import 'package:flutter/material.dart';

const String mainScreen = 'mainScreen';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case mainScreen:
      return MaterialPageRoute(builder: (_)=> MainScreen());
      break;
  }

}