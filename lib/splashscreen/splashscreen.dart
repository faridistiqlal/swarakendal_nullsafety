import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:async';
import 'package:swarakendal/halaman/radio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
    _initPackageInfo();
  }

  //NOTE Set variable package Info
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
//NOTE GET Package Info
  Future _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      print("------------------------------");
      print(_packageInfo.appName);
      print(_packageInfo.packageName);
      print(_packageInfo.version);
      print(_packageInfo.buildNumber);
    });
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return const SwaraKendal(); //masuk halaman login
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.2),
            ),
            Image.asset(
              "assets/logo/logo.png",
              width: mediaQueryData.size.width * 0.5,
              height: mediaQueryData.size.height * 0.5,
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/logokendal.png',
                  width: 50.0,
                  height: 50.0,
                ),
                const Text(
                  " Pemerintah \n Kabupaten Kendal",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.03),
            ),
            Text(
              _packageInfo.version.toString(),
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
