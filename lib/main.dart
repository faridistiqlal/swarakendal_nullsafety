import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swarakendal/splashscreen/splashscreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light),
  );
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFfdede9),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      routes: <String, WidgetBuilder>{
        '/SplashScreen': (BuildContext context) => const SplashScreen(),
      },
      home: const SplashScreen(),
    ),
  );
}
