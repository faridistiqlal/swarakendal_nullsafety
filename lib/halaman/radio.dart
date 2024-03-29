import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:radio_player/radio_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

class SwaraKendal extends StatefulWidget {
  const SwaraKendal({Key? key}) : super(key: key);

  @override
  State<SwaraKendal> createState() => _SwaraKendalState();
}

class _SwaraKendalState extends State<SwaraKendal> {
  //REVIEW
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: 'Radio Player',
      url: "http://i.klikhost.com/8822/stream/",
      imagePath: 'assets/logo/logo1.png',
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  // AudioPlayer audioPlayer = AudioPlayer();

  void getAudio() async {
    // var url = "http://i.klikhost.com/8822/stream/";
    // setState(() {
    //   audioPlayer.play(url);
    // });
  }

  static var today = DateTime.now();
  var formatedTanggal = DateFormat.yMMMd().format(today);
  late String _timeString;
  late String _dayString;
  late String _hari;

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

  String _formatHari(DateTime dateTime) {
    return DateFormat(
      'EEEEE',
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
    if (kDebugMode) {
      print("jam" + _timeString);
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
          _dayString = formattedDateDay;
        },
      );
    }
    return formattedDateDay;
  }

  Future _getHari() async {
    initializeDateFormatting('id_ID', null);
    final DateTime now = DateTime.now();
    final String formattedHari = _formatHari(now);
    if (mounted) {
      setState(
        () {
          _hari = formattedHari;
        },
      );
    }
    return formattedHari;
  }

  @override
  void initState() {
    super.initState();
    // getAudio();
    //REVIEW
    initRadioPlayer();
    _getDay();
    _getHari();
    initializeDateFormatting();
    _timeString = _formatDateTime(DateTime.now());
    _dayString = _formatDateDay(DateTime.now());
    _hari = _formatHari(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    Wakelock.enable();
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
            _dayString,
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
              top: 15,
              left: 15,
              right: 15,
            ),
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height * 0.6,
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
                        Navigator.pushNamed(context, '/MyApp');
                      },
                    ),
                    //Remove code spinkit
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
                    final Uri url = Uri.parse(
                        'https://api.whatsapp.com/send?phone=6282325709993&text=silahkan+ketik+nama%25alamat%25isipesan%25rekuest');
                    if (!await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw 'Could not launch $url';
                    }
                    // const url =
                    //     'https://api.whatsapp.com/send?phone=6282325709993&text=silahkan+ketik+nama%25alamat%25isipesan%25rekuest';
                    // if (await canLaunch(url)) {
                    //   await launch(url, forceSafariVC: false);
                    // } else {
                    //   throw 'Could not launch $url';
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    backgroundColor: Colors.white,
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
            top: mediaQueryData.size.height * 0.05,
            left: mediaQueryData.size.height * 0.28,
            child: Column(
              children: [
                FutureBuilder(
                  future: _radioPlayer.getArtworkImage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Image artwork;
                    if (snapshot.hasData) {
                      artwork = snapshot.data;
                    } else {
                      artwork = Image.asset(
                        'assets/logo/logo1.png',
                        fit: BoxFit.cover,
                      );
                    }
                    return SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        child: artwork,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mediaQueryData.size.height * 0.01)),
                ElevatedButton(
                  onPressed: () {
                    isPlaying ? _radioPlayer.stop() : _radioPlayer.play();
                  },
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: const Color(0xFFe97b65),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(15), // <-- Button color
                    // onPrimary: Colors.red, // <-- Splash color
                  ),
                )
              ],
            ),
            // child: Image.asset(
            //   'assets/logo/1.png',
            //   width: 250.0,
            //   height: 250.0,
            // ),
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
      height: mediaQueryData.size.height * 0.28,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                  backgroundColor: const Color(0xFFe97b65),
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
                //text
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
          // const Divider(),
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
                  backgroundColor: Colors.grey,
                ),
                label: const Text(
                  'Acara Selanjutnya',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.angleDoubleRight,
                  color: Colors.white,
                  size: 20,
                ),
                //text
                // textColor: Color(0xFFe97b65),
                // splashColor: Colors.red,
                // color: Colors.white,
              ),
              // Padding(
              //     padding: EdgeInsets.only(
              //         right: mediaQueryData.size.height * 0.01)),
              // const SpinKitDoubleBounce(
              //   color: Color(0xFFe97b65),
              //   size: 30,
              // ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: mediaQueryData.size.height * 0.01)),
          _runningnext()
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
    var siaran;
    if (_hari == 'Senin' ||
        _hari == 'Selasa' ||
        _hari == 'Rabu' ||
        _hari == 'Kamis' ||
        _hari == 'Jumat' ||
        _hari == 'Sabtu' ||
        _hari == 'Minggu') {
      if (_timeString == '06') {
        siaran = "PACU SEMANGAT";
      } else if (_timeString == '07' || _timeString == '08') {
        siaran = "BERANDA KITA";
      } else if (_timeString == '09' || _timeString == '10') {
        if (_hari == 'Minggu') {
          siaran = "DUNIA ANAK (09.00-09.30) & CERITA NUSANTARA (09.30-10.00)";
        } else {
          siaran = "PASAR SWARA KENDAL";
        }
      } else if (_timeString == '11' || _timeString == '12') {
        if (_hari == 'Minggu') {
          siaran = "RHOMANIA";
        } else {
          siaran = "ES CAMPUR";
        }
      } else if (_timeString == '13') {
        if (_hari == 'Minggu') {
          siaran = "SEJENAK BERSAMA";
        } else {
          siaran = "REHAT SIANG";
        }
      } else if (_timeString == '14' || _timeString == '15') {
        if (_hari == 'Sabtu') {
          siaran = "FBI";
        } else if (_hari == 'Minggu') {
          siaran = "SLANK MANIA";
        } else {
          siaran = "MUSIK INDO";
        }
      } else if (_timeString == '16' || _timeString == '17') {
        if (_hari == 'Minggu') {
          siaran = "MUSIKIDI (16.00-17.00) & IWAN FALS(17.00-18.00)";
        } else {
          siaran = "JJS";
        }
      } else if (_timeString == '18') {
        if (_hari == 'Sabtu') {
          siaran = "RISALAH (18.30-19.00)";
        } else if (_hari == 'Minggu') {
          siaran = "REBANA LOKAL (18.30-19.00)";
        } else {
          siaran = "BAHANA SWARA KENDAL";
        }
      } else if (_timeString == '19' || _timeString == '20') {
        if (_hari == 'Minggu') {
          siaran =
              "Hikmah dibalik Kisah (19.00-20.00) & MIMBAR KRISTEN(20.00-20.30) & MIMBAR KATOLIK(20.30-21.00)";
        } else {
          siaran = "PLANET GAUL";
        }
      } else if (_timeString == '21') {
        if (_hari == 'Jumat') {
          siaran = "KOESPLUS MANIA";
        } else {
          siaran = "MELODI KENANGAN";
        }
      } else if (_timeString == '22' || _timeString == '23') {
        if (_hari == 'Jumat') {
          siaran = "LANOSDA";
        } else {
          siaran = "GADO GADO";
        }
      } else {
        siaran = "OFFLINE";
      }
    }
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
                text: siaran.toString(),
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
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

  Widget _runningnext() {
    var siaran;
    if (_hari == 'Senin' ||
        _hari == 'Selasa' ||
        _hari == 'Rabu' ||
        _hari == 'Kamis' ||
        _hari == 'Jumat' ||
        _hari == 'Sabtu' ||
        _hari == 'Minggu') {
      if (_timeString == '06') {
        siaran = "BERANDA KITA";
      } else if (_timeString == '07' || _timeString == '08') {
        if (_hari == 'Minggu') {
          siaran = "DUNIA ANAK (09.00-09.30) & CERITA NUSANTARA (09.30-10.00)";
        } else {
          siaran = "PASAR SWARA KENDAL";
        }
      } else if (_timeString == '09' || _timeString == '10') {
        if (_hari == 'Minggu') {
          siaran = "RHOMANIA";
        } else {
          siaran = "ES CAMPUR";
        }
      } else if (_timeString == '11' || _timeString == '12') {
        if (_hari == 'Minggu') {
          siaran = "SEJENAK BERSAMA";
        } else {
          siaran = "REHAT SIANG";
        }
      } else if (_timeString == '13') {
        if (_hari == 'Sabtu') {
          siaran = "FBI";
        } else if (_hari == 'Minggu') {
          siaran = "SLANK MANIA";
        } else {
          siaran = "MUSIK INDO";
        }
      } else if (_timeString == '14' || _timeString == '15') {
        if (_hari == 'Minggu') {
          siaran = "MUSIKIDI (16.00-17.00) & IWAN FALS(17.00-18.00)";
        } else {
          siaran = "JJS";
        }
      } else if (_timeString == '16' || _timeString == '17') {
        if (_hari == 'Sabtu') {
          siaran = "RISALAH (18.30-19.00)";
        } else if (_hari == 'Minggu') {
          siaran = "REBANA LOKAL (18.30-19.00)";
        } else {
          siaran = "BAHANA SWARA KENDAL";
        }
      } else if (_timeString == '18') {
        if (_hari == 'Minggu') {
          siaran =
              "Hikmah dibalik Kisah (19.00-20.00) & MIMBAR KRISTEN(20.00-20.30) & MIMBAR KATOLIK(20.30-21.00)";
        } else {
          siaran = "PLANET GAUL";
        }
      } else if (_timeString == '19' || _timeString == '20') {
        if (_hari == 'Jumat') {
          siaran = "KOESPLUS MANIA";
        } else {
          siaran = "MELODI KENANGAN";
        }
      } else if (_timeString == '21') {
        if (_hari == 'Jumat') {
          siaran = "LANOSDA";
        } else {
          siaran = "GADO GADO";
        }
      } else if (_timeString == '22' || _timeString == '23') {
        siaran = "OFFLINE";
      } else {
        siaran = "OFFLINE";
      }
    }
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      // padding: const EdgeInsets.all(10),
      width: mediaQueryData.size.width,
      height: mediaQueryData.size.height * 0.07,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              siaran,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new_rounded,
              color: Colors.brown[800],
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        _tanggal(),
        // _card(),
        _futureCard(),
        _info()
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
      //   },
      //   tooltip: 'Control button',
      //   child: Icon(
      //     isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
      //   ),
      // ),
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
                          final Uri url = Uri.parse('https://swarakendal.com/');
                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw 'Could not launch $url';
                          }
                          // const url = 'https://swarakendal.com/';
                          // if (await canLaunch(url)) {
                          //   await launch(url, forceSafariVC: false);
                          // } else {
                          //   throw 'Could not launch $url';
                          // }
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
                          final Uri url = Uri.parse(
                              'https://www.facebook.com/radioswarakendalfm');
                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw 'Could not launch $url';
                          }
                          // const url =
                          //     'https://www.facebook.com/radioswarakendalfm';
                          // if (await canLaunch(url)) {
                          //   await launch(url, forceSafariVC: false);
                          // } else {
                          //   throw 'Could not launch $url';
                          // }
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
                          final Uri url = Uri.parse(
                              'https://www.youtube.com/channel/UCKHCg8Kghp2C1GbAuExqBVA');
                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw 'Could not launch $url';
                          }
                          // const url =
                          //     'https://www.youtube.com/channel/UCKHCg8Kghp2C1GbAuExqBVA';
                          // if (await canLaunch(url)) {
                          //   await launch(url, forceSafariVC: false);
                          // } else {
                          //   throw 'Could not launch $url';
                          // }
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
                          final Uri url = Uri.parse(
                              'https://www.instagram.com/swarakendalfm/?hl=id');
                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw 'Could not launch $url';
                          }
                          // const url =
                          //     'https://www.instagram.com/swarakendalfm/?hl=id';
                          // if (await canLaunch(url)) {
                          //   await launch(url, forceSafariVC: false);
                          // } else {
                          //   throw 'Could not launch $url';
                          // }
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
                        child: const Icon(
                          Icons.whatsapp,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final Uri url = Uri.parse(
                              'https://api.whatsapp.com/send?phone=6282325709993&text=Halo+swara+kendal');
                          if (!await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw 'Could not launch $url';
                          }
                          // const url =
                          //     'https://api.whatsapp.com/send?phone=6282325709993&text=Halo+swara+kendal';
                          // if (await canLaunch(url)) {
                          //   await launch(url, forceSafariVC: false);
                          // } else {
                          //   throw 'Could not launch $url';
                          // }
                        },
                      ),
                    ),
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
            child: _card(),
          );
        } else {
          return const Text("loading");
        }
      },
    );
  }

  Widget cardBerita2() {
    var warna;
    if (_hari == 'Senin') {
      if (_timeString == '06' || _timeString == '07') {
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
}
