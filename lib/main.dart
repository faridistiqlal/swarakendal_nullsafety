import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swarakendal/splashscreen/splashscreen.dart';
// import 'halaman/cek.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light),
  );
  runApp(
    MaterialApp(
      theme: ThemeData(
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        primaryColor: const Color(0xFFfdede9),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      routes: <String, WidgetBuilder>{
        '/SplashScreen': (BuildContext context) => const SplashScreen(),
        // '/MyApp': (BuildContext context) => const MyApp(),
      },
      home: const SplashScreen(),
    ),
  );
}
