import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';

void main()=>runApp(MaterialApp(
  initialRoute: '/', //this will override the base route in the routes map
  routes: {
    '/': (context)=>const Loading(), //base route; when the application first starts
    '/home': (context)=>const Home(),
    '/location': (context)=>const ChooseLocation(),
  },
));