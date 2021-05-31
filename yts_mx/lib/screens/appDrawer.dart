import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Drawer appDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  radius: 0.7, colors: [Colors.green, Colors.black])),
          child: Column(
            children: [
              CircleAvatar(
                child: Image.asset(
                  "images/logo-YTS.png",
                ),
                // foregroundColor: Colors.black,
                radius: 55.0,
              ),
              Container(
                margin: const EdgeInsets.only(top: 3.5, bottom: 3.5),
              ),
              Text(
                "Crafted with ❤ by CRYP73R",
                style: TextStyle(
                  // fontStyle: FontStyle.italic,
                  fontSize: 17.0,
                  letterSpacing: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home_outlined,
            color: Colors.pink,
          ),
          title: Text("HOME"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.notifications_active_outlined,
            color: Colors.red,
          ),
          title: Text("ANNOUNCEMENTS"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/announcementScreen");
          },
        ),
        ListTile(
          leading: Icon(
            Icons.workspaces_outline,
            color: Colors.deepOrangeAccent,
          ),
          title: Text("HOW TO DOWNLOAD"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/howToDownloadScreen");
          },
        ),
        ListTile(
          leading: Icon(
            Icons.link,
            color: Colors.deepPurpleAccent,
          ),
          title: Text("TRACKERS LIST"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/trackerListScreen");
          },
        ),
        ListTile(
          leading: Icon(
            Icons.bug_report_outlined,
            color: Colors.yellow,
          ),
          title: Text("REPORT A PROBLEM"),
          onTap: () async {
            final String _formUrl =
                "https://docs.google.com/forms/d/e/1FAIpQLSdFwATdFCd2N-4hO_omPInGzxCWh13m8Px8o01xF4Q3TreaqA/viewform?usp=sf_link";
            if (await canLaunch(_formUrl)) {
              await launch(_formUrl);
            }
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(
            Icons.system_update,
            color: Colors.green,
          ),
          title: Text("CHECK FOR UPDATES"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/updateAppScreen");
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: Colors.blue,
          ),
          title: Text("ABOUT US"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/aboutUsScreen");
          },
        ),
      ],
    ),
  );
}
