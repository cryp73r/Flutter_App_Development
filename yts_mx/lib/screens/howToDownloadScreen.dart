import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yts_mx/screens/appDrawer.dart';

class HowToDownloadScreen extends StatelessWidget {
  const HowToDownloadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How To Download"),
        centerTitle: true,
      ),
      body: stepsHolder(),
      drawer: appDrawer(context),
    );
  }

  Widget stepsHolder() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            "Steps",
            style: headingStyle(),
            textAlign: TextAlign.justify,
          ),
          Text(
            "1. Install any Torrent Client.",
            style: bodyStyle(),
            textAlign: TextAlign.justify,
          ),
          Text(
            "2. Press on desired quality button.",
            style: bodyStyle(),
            textAlign: TextAlign.justify,
          ),
          Text(
            "3. Add Torrent for Downloading.",
            style: bodyStyle(),
            textAlign: TextAlign.justify,
          ),
          Text(
            "4. You are Done. Now wait for Download to Complete.",
            style: bodyStyle(),
            textAlign: TextAlign.justify,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          ),
          Text(
            "In-case of slow speed",
            style: headingStyle(),
            textAlign: TextAlign.justify,
          ),
          Text(
            "You can try adding Trackers from Trackers List. Well, by default, we have added recommended Trackers by yts.mx",
            style: bodyStyle(),
            textAlign: TextAlign.justify,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          ),
          Text(
            "Suggested Torrent Clients",
            style: headingStyle(),
            textAlign: TextAlign.justify,
          ),
          InkWell(
            child: Container(
                margin: const EdgeInsets.only(top: 7.0),
                child: Text(
                  "1. Flud - Torrent Downloader (Made in India)",
                  style: linkStyle(),
                  textAlign: TextAlign.justify,
                )),
            onTap: () async {
              if (await canLaunch(
                  "https://play.google.com/store/apps/details?id=com.delphicoder.flud")) {
                await launch(
                    "https://play.google.com/store/apps/details?id=com.delphicoder.flud");
              } else {
                throw "Could not launch";
              }
            },
          ),
          InkWell(
            child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "2. LibreTorrent",
                  style: linkStyle(),
                  textAlign: TextAlign.justify,
                )),
            onTap: () async {
              if (await canLaunch(
                  "https://play.google.com/store/apps/details?id=org.proninyaroslav.libretorrent")) {
                await launch(
                    "https://play.google.com/store/apps/details?id=org.proninyaroslav.libretorrent");
              } else {
                throw "Could not launch";
              }
            },
          ),
          InkWell(
            child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "3. BitTorrent® - Torrent Downloads",
                  style: linkStyle(),
                  textAlign: TextAlign.justify,
                )),
            onTap: () async {
              if (await canLaunch(
                  "https://play.google.com/store/apps/details?id=com.bittorrent.client")) {
                await launch(
                    "https://play.google.com/store/apps/details?id=com.bittorrent.client");
              } else {
                throw "Could not launch";
              }
            },
          ),
          InkWell(
            child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "4. µTorrent® - Torrent Downloader",
                  style: linkStyle(),
                  textAlign: TextAlign.justify,
                )),
            onTap: () async {
              if (await canLaunch(
                  "https://play.google.com/store/apps/details?id=com.utorrent.client")) {
                await launch(
                    "https://play.google.com/store/apps/details?id=com.utorrent.client");
              } else {
                throw "Could not launch";
              }
            },
          ),
          InkWell(
            child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "5. WeTorrent - Torrent Downloader",
                  style: linkStyle(),
                  textAlign: TextAlign.justify,
                )),
            onTap: () async {
              if (await canLaunch(
                  "https://play.google.com/store/apps/details?id=co.we.torrent")) {
                await launch(
                    "https://play.google.com/store/apps/details?id=co.we.torrent");
              } else {
                throw "Could not launch";
              }
            },
          ),
        ],
      ),
    );
  }

  TextStyle headingStyle() {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white70,
      letterSpacing: 1.5,
    );
  }

  TextStyle bodyStyle() {
    return TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
      color: Colors.white60,
      letterSpacing: 1.0,
    );
  }

  TextStyle linkStyle() {
    return TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
      color: Colors.deepPurpleAccent,
      letterSpacing: 1.0,
    );
  }
}
