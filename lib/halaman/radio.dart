import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

class SwaraKendal extends StatefulWidget {
  const SwaraKendal({Key? key}) : super(key: key);

  @override
  State<SwaraKendal> createState() => _SwaraKendalState();
}

class _SwaraKendalState extends State<SwaraKendal> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();

  bool playing = false;
  void getAudio() async {
    var url = "http://i.klikhost.com/8822/stream/";
    setState(() {
      audioPlayer.play(url);
    });
  }

  static var today = DateTime.now();
  var formatedTanggal = DateFormat.yMMMd().format(today);
  late String _timeString;
  late String _DayString;

  String _formatDateTime(DateTime dateTime) {
    return DateFormat(
      'HH',
      // 'EEEEE dd MMMM yyyy HH:mm:ss',
      'id_ID',
    ).format(dateTime);
  }

  String _formatDateDay(DateTime dateTime) {
    return DateFormat(
      'EEEEE dd MMMM yyyy',
      // 'EEEEE dd MMMM yyyy HH:mm:ss',
      'id_ID',
    ).format(dateTime);
  }

  Future _getTime() async {
    initializeDateFormatting('id_ID', null);
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(
        () {
          _timeString = formattedDateTime;
        },
      );
    }
    return formattedDateTime;
  }

  Future _getDay() async {
    initializeDateFormatting('id_ID', null);
    final DateTime now = DateTime.now();
    final String formattedDateDay = _formatDateDay(now);
    if (mounted) {
      setState(
        () {
          _DayString = formattedDateDay;
        },
      );
    }
    return formattedDateDay;
  }

  // late VideoPlayerController videoPlayerController;
  // late Future<void> videoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _getDay();
    getAudio();
    initializeDateFormatting();
    _timeString = _formatDateTime(DateTime.now());
    _DayString = _formatDateDay(DateTime.now());
    // Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    Wakelock.enable();
    // videoPlayerController =
    //     VideoPlayerController.network('http://i.klikhost.com/8822/stream');
    // videoPlayerFuture = videoPlayerController.initialize();

    // videoPlayerController.setLooping(false);
  }

  @override
  void dispose() {
    // videoPlayerController.dispose();
    super.dispose();
  }

  Widget _judul1() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
        padding: EdgeInsets.only(
          left: mediaQueryData.size.height * 0.02,
          top: mediaQueryData.size.height * 0.02,
        ),
        child: Text(
          'Streaming',
          style: TextStyle(
            color: Colors.brown[800],
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ));
  }

  Widget _tanggal() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height * 0.07,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      padding: EdgeInsets.only(
        top: mediaQueryData.size.height * 0.02,
        left: mediaQueryData.size.height * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _DayString,
            style: TextStyle(
              color: Colors.brown[800],
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _card() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height * 0.58,
            decoration: const BoxDecoration(
              color: Color(0xFFe97b65),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Streaming Radio",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.size.height * 0.01)),
                const Text(
                  "Dengarkan siaran langsung \nRadio Swara Kendal",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(formatedTanggal.toString()),
                // Divider(
                //   color: Colors.white,
                //   height: mediaQueryData.size.height * 0.02,
                //   endIndent: mediaQueryData.size.width * 0.4,
                // ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.size.height * 0.03)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // videoPlayerController.value.isPlaying
                    //     ?
                    IconButton(
                      icon: const Icon(
                        Icons.radio_rounded,
                        color: Colors.black54,
                        size: 30,
                      ),
                      onPressed: () {
                        // Navigator.pushNamed(context, '/MyApp');
                      },
                    ),
                    // :
                    // const SpinKitCircle(
                    //     color: Colors.white,
                    //     // size: 30,
                    //   ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: mediaQueryData.size.height * 0.01)),
                    const Text(
                      "93 FM",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  // child:
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.size.height * 0.02)),
                ElevatedButton.icon(
                  // elevation: 0,
                  onPressed: () async {
                    const url =
                        'https://api.whatsapp.com/send?phone=6282325709993&text=silahkan+ketik+nama%25alamat%25isipesan%25rekuest';
                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    primary: Colors.white,
                  ),

                  label: const Text(
                    'Request lagu',
                    style: TextStyle(
                      color: Color(0xFFe97b65),
                    ),
                  ),
                  icon: const Icon(
                    Icons.music_note,
                    color: Color(0xFFe97b65),
                  ),
                  // textColor: Color(0xFFe97b65),
                  // splashColor: Colors.red,
                  // color: Colors.white,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.size.height * 0.02)),
                _insideCard(),
              ],
            ),
          ),
          Positioned(
            top: mediaQueryData.size.height * 0.04,
            left: mediaQueryData.size.height * 0.25,
            child: Image.asset(
              'assets/logo/1.png',
              width: 250.0,
              height: 250.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _insideCard() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height * 0.25,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                // elevation: 0,
                onPressed: () async {
                  //
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  primary: const Color(0xFFe97b65),
                ),

                label: const Text(
                  'Siaran saat ini',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.podcast,
                  color: Colors.white,
                  size: 20,
                ),
                // textColor: Color(0xFFe97b65),
                // splashColor: Colors.red,
                // color: Colors.white,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      right: mediaQueryData.size.height * 0.01)),
              const SpinKitDoubleBounce(
                color: Color(0xFFe97b65),
                size: 30,
              ),
            ],
          ),
          _running(),
          const Divider(),
          // Expanded(
          //   child: SizedBox(
          //     child: Marquee(
          //       text: 'Sunday Morning',
          //       style: const TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //       blankSpace: 30.0,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _running() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      // padding: const EdgeInsets.all(10),
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height * 0.05,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Marquee(
                text: 'Sunday Morning',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                blankSpace: 30.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.radio_rounded,
        //     color: Colors.brown[800],
        //     size: 30,
        //   ),
        //   onPressed: () {
        //     // Navigator.pushNamed(context, '/MyApp');
        //   },
        // ),
        elevation: 0,
        title: Text(
          'Swara Kendal',
          style: TextStyle(
            color: Colors.brown[800],
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        _tanggal(),
        _card(),
        _info()
        // child: Container(
        //   width: mediaQueryData.size.width,
        //   height: mediaQueryData.size.height * 0.15,
        //   decoration: const BoxDecoration(
        //     color: Colors.blue,
        //     // borderRadius: BorderRadius.all(Radius.circular(30.0)),
        //   ),
        //   padding: const EdgeInsets.all(10),
        // child: Column(
        //   children: [
        // Stack(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.only(
        //         top: 20,
        //         left: 20,
        //         right: 20,
        //       ),
        //       width: mediaQueryData.size.width,
        //       height: mediaQueryData.size.height * 0.3,
        //       decoration: const BoxDecoration(
        //         color: Color(0xFFe97b65),
        //         borderRadius: BorderRadius.all(Radius.circular(30.0)),
        //       ),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Text(
        //                 "Streaming Radio",
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 25,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               Text(
        //                 formatedTanggal.toString(),
        //                 style: const TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 15,
        //                   // fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Padding(
        //               padding: EdgeInsets.only(
        //                   top: mediaQueryData.size.height * 0.01)),
        //           const Text(
        //             "Dengarkan siaran langsung \nRadio Swara Kendal",
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 15,
        //               // fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           // Text(formatedTanggal.toString()),
        //           // Divider(
        //           //   color: Colors.white,
        //           //   height: mediaQueryData.size.height * 0.02,
        //           //   endIndent: mediaQueryData.size.width * 0.4,
        //           // ),
        //           Padding(
        //               padding: EdgeInsets.only(
        //                   top: mediaQueryData.size.height * 0.03)),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             // crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               // videoPlayerController.value.isPlaying
        //               //     ?
        //               const SpinKitDoubleBounce(
        //                 color: Colors.white,
        //               ),
        //               // :
        //               // const SpinKitCircle(
        //               //     color: Colors.white,
        //               //     // size: 30,
        //               //   ),
        //               Padding(
        //                   padding: EdgeInsets.only(
        //                       left: mediaQueryData.size.height * 0.01)),
        //               const Text(
        //                 "93 FM",
        //                 style: TextStyle(
        //                   color: Colors.black54,
        //                   fontSize: 30,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //             ],
        //             // child:
        //           ),
        //           Padding(
        //               padding: EdgeInsets.only(
        //                   top: mediaQueryData.size.height * 0.02)),
        //           ElevatedButton.icon(
        //             // elevation: 0,
        //             onPressed: () async {
        //               const url =
        //                   'https://api.whatsapp.com/send?phone=6282325709993&text=silahkan+ketik+nama%25alamat%25isipesan%25rekuest';
        //               if (await canLaunch(url)) {
        //                 await launch(url, forceSafariVC: false);
        //               } else {
        //                 throw 'Could not launch $url';
        //               }
        //             },
        //             style: ElevatedButton.styleFrom(
        //               shape: const RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(
        //                   Radius.circular(30.0),
        //                 ),
        //               ),
        //               primary: Colors.white,
        //             ),

        //             label: const Text(
        //               'Request lagu',
        //               style: TextStyle(
        //                 color: Color(0xFFe97b65),
        //               ),
        //             ),
        //             icon: const Icon(
        //               Icons.multitrack_audio_sharp,
        //               color: Color(0xFFe97b65),
        //             ),
        //             // textColor: Color(0xFFe97b65),
        //             // splashColor: Colors.red,
        //             // color: Colors.white,
        //           ),
        //         ],
        //       ),
        //     ),
        //     Positioned(
        //       top: mediaQueryData.size.height * 0.04,
        //       left: mediaQueryData.size.height * 0.25,
        //       child: Image.asset(
        //         'assets/logo/1.png',
        //         width: 250.0,
        //         height: 250.0,
        //       ),
        //     ),
        //   ],
        // ),
        // Padding(
        //     padding:
        //         EdgeInsets.only(top: mediaQueryData.size.height * 0.02)),
        // Column(
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   // crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Row(
        //       children: [
        //         Text(
        //           "Host " + _timeString,
        //           style: TextStyle(
        //             color: Colors.brown[800],
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Padding(
        //         padding: EdgeInsets.only(
        //             top: mediaQueryData.size.height * 0.01)),
        //   ],
        // ),
        // Padding(
        //     padding:
        //         EdgeInsets.only(top: mediaQueryData.size.height * 0.02)),
        // Column(
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   // crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Row(
        //       children: [
        //         Text(
        //           "Info ",
        //           style: TextStyle(
        //             color: Colors.brown[800],
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Padding(
        //         padding: EdgeInsets.only(
        //             top: mediaQueryData.size.height * 0.01)),
        //     Stack(
        //       children: [
        //         Container(
        //           padding: const EdgeInsets.all(10),
        //           width: mediaQueryData.size.width,
        //           height: mediaQueryData.size.height * 0.1,
        //           decoration: BoxDecoration(
        //             color: Theme.of(context).primaryColor,
        //             border: Border.all(color: Colors.grey, width: 1),
        //             borderRadius:
        //                 const BorderRadius.all(Radius.circular(20.0)),
        //           ),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               ElevatedButton.icon(
        //                 // elevation: 0,
        //                 onPressed: () async {
        //                   const url = 'https://swarakendal.com/';
        //                   if (await canLaunch(url)) {
        //                     await launch(url, forceSafariVC: false);
        //                   } else {
        //                     throw 'Could not launch $url';
        //                   }
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                   elevation: 0,
        //                   shape: const RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(30.0),
        //                     ),
        //                   ),
        //                   primary: const Color(0xFFe97b65),
        //                 ),
        //                 label: const Text(
        //                   'Website',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //                 icon: const Icon(
        //                   Icons.language,
        //                   color: Colors.white,
        //                   size: 20,
        //                 ),
        //                 // textColor: Color(0xFFe97b65),
        //                 // splashColor: Colors.red,
        //                 // color: Colors.white,
        //               ),
        //               ElevatedButton.icon(
        //                 // elevation: 0,
        //                 onPressed: () async {
        //                   const url =
        //                       'https://www.instagram.com/swarakendalfm/?hl=id';
        //                   if (await canLaunch(url)) {
        //                     await launch(url, forceSafariVC: false);
        //                   } else {
        //                     throw 'Could not launch $url';
        //                   }
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                   elevation: 0,
        //                   shape: const RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(30.0),
        //                     ),
        //                   ),
        //                   primary: const Color(0xFFe97b65),
        //                 ),
        //                 label: const Text(
        //                   'Instagram',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //                 icon: const FaIcon(
        //                   FontAwesomeIcons.instagram,
        //                   color: Colors.white,
        //                   size: 20,
        //                 ),
        //                 // textColor: Color(0xFFe97b65),
        //                 // splashColor: Colors.red,
        //                 // color: Colors.white,
        //               ),
        //               ElevatedButton.icon(
        //                 // elevation: 0,
        //                 onPressed: () async {
        //                   const url = 'tel://082325709993';
        //                   if (await canLaunch(url)) {
        //                     await launch(url, forceSafariVC: false);
        //                   } else {
        //                     throw 'Could not launch $url';
        //                   }
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                   elevation: 0,
        //                   shape: const RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(30.0),
        //                     ),
        //                   ),
        //                   primary: const Color(0xFFe97b65),
        //                 ),
        //                 label: const Text(
        //                   'Telepon',
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //                 icon: const Icon(
        //                   Icons.phone,
        //                   color: Colors.white,
        //                   size: 20,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        // _futureCard(),
        //   ],
        // ),
        // ),
      ]),
    );
  }

  Widget _info() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Sapa Kami ",
                style: TextStyle(
                  color: Colors.brown[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.01)),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height * 0.1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFe97b65),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      // color: Colors.orange,
                      height: 50.0,
                      width: 50.0,
                      child: TextButton(
                        child: const FaIcon(
                          FontAwesomeIcons.globe,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () async {
                          const url = 'https://swarakendal.com/';
                          if (await canLaunch(url)) {
                            await launch(url, forceSafariVC: false);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFe97b65),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      // color: Colors.orange,
                      height: 50.0,
                      width: 50.0,
                      child: TextButton(
                        child: const FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () async {
                          const url =
                              'https://www.facebook.com/radioswarakendalfm';
                          if (await canLaunch(url)) {
                            await launch(url, forceSafariVC: false);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFe97b65),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      // color: Colors.orange,
                      height: 50.0,
                      width: 50.0,
                      child: TextButton(
                        child: const FaIcon(
                          FontAwesomeIcons.youtube,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () async {
                          const url =
                              'https://www.youtube.com/channel/UCKHCg8Kghp2C1GbAuExqBVA';
                          if (await canLaunch(url)) {
                            await launch(url, forceSafariVC: false);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   // elevation: 0,
                    //   onPressed: () async {
                    //     const url = 'https://swarakendal.com/';
                    //     if (await canLaunch(url)) {
                    //       await launch(url, forceSafariVC: false);
                    //     } else {
                    //       throw 'Could not launch $url';
                    //     }
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     elevation: 0,
                    //     shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(30.0),
                    //       ),
                    //     ),
                    //     primary: const Color(0xFFe97b65),
                    //   ),
                    //   label: const Text(
                    //     'Website',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   icon: const Icon(
                    //     Icons.language,
                    //     color: Colors.white,
                    //     size: 20,
                    //   ),
                    //   // textColor: Color(0xFFe97b65),
                    //   // splashColor: Colors.red,
                    //   // color: Colors.white,
                    // ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFe97b65),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      // color: Colors.orange,
                      height: 50.0,
                      width: 50.0,
                      child: TextButton(
                        child: const FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () async {
                          const url =
                              'https://www.instagram.com/swarakendalfm/?hl=id';
                          if (await canLaunch(url)) {
                            await launch(url, forceSafariVC: false);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   // elevation: 0,
                    //   onPressed: () async {
                    //     const url =
                    //         'https://www.instagram.com/swarakendalfm/?hl=id';
                    //     if (await canLaunch(url)) {
                    //       await launch(url, forceSafariVC: false);
                    //     } else {
                    //       throw 'Could not launch $url';
                    //     }
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     elevation: 0,
                    //     shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(30.0),
                    //       ),
                    //     ),
                    //     primary: const Color(0xFFe97b65),
                    //   ),
                    //   label: const Text(
                    //     'Instagram',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   icon: const FaIcon(
                    //     FontAwesomeIcons.instagram,
                    //     color: Colors.white,
                    //     size: 20,
                    //   ),
                    //   // textColor: Color(0xFFe97b65),
                    //   // splashColor: Colors.red,
                    //   // color: Colors.white,
                    // ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFe97b65),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      // color: Colors.orange,
                      height: 50.0,
                      width: 50.0,
                      child: TextButton(
                        child: const Icon(
                          Icons.whatsapp,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          const url =
                              'https://api.whatsapp.com/send?phone=6282325709993&text=Halo+swara+kendal';
                          if (await canLaunch(url)) {
                            await launch(url, forceSafariVC: false);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   // elevation: 0,
                    //   onPressed: () async {
                    //     const url = 'tel://082325709993';
                    //     if (await canLaunch(url)) {
                    //       await launch(url, forceSafariVC: false);
                    //     } else {
                    //       throw 'Could not launch $url';
                    //     }
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     elevation: 0,
                    //     shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(30.0),
                    //       ),
                    //     ),
                    //     primary: const Color(0xFFe97b65),
                    //   ),
                    //   label: const Text(
                    //     'Telepon',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   icon: const Icon(
                    //     Icons.phone,
                    //     color: Colors.white,
                    //     size: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _futureCard() {
    return FutureBuilder(
      future: _getTime(), // a previously-obtained Future<String> or null
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: cardBerita2(),
          );
        } else {
          return const Text("loading");
        }
      },
    );
  }

  Widget cardBerita2() {
    var warna;
    if (_timeString == '17') {
      warna = const Text(
        "Senin",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      );
    } else {
      warna = const Text(
        "Selasa",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height * 0.1,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.black.withOpacity(0.1),
          //       offset: Offset(0.0, 3.0),
          //       blurRadius: 15.0)
          // ],
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: mediaQueryData.size.height * 0.01,
            left: mediaQueryData.size.height * 0.01,
            right: mediaQueryData.size.height * 0.01,
            //bottom: mediaQueryData.size.height * 0.01,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        _timeString,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                      warna,
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget slider() {
  //   return Slider.adaptive(
  //     min: 0.0,
  //     value: position.inSeconds.toDouble(),
  //     max: duration.inSeconds.toDouble(),
  //     onChanged: (double value) {
  //       setState(() {
  //         audioPlayer.seek(Duration(seconds: value.toInt()));
  //       });
  //     },
  //   );
  // }
}
