import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yts_mx/screens/homeScreen.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/logo-YTS.png",
        ),
        actions: [
          searchButton(),
        ],
      ),
      body: HomeScreen(),
      drawer: appDrawer(context),
    );
  }

  IconButton searchButton() {
    return IconButton(
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: () => debugPrint("Search"),
    );
  }

  Drawer appDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.7,
                colors: [Colors.green, Colors.black]
              )
            ),
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
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
              color: Colors.red,
            ),
            title: Text("ANNOUNCEMENTS"),
            onTap: () {
              debugPrint("Announcements");
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => NoticeScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.report_gmailerrorred_outlined,
              color: Colors.yellow,
            ),
            title: Text("REPORT A PROBLEM"),
            onTap: () async {
              final String _formUrl = "https://docs.google.com/forms/d/e/1FAIpQLSdFwATdFCd2N-4hO_omPInGzxCWh13m8Px8o01xF4Q3TreaqA/viewform?usp=sf_link";
              if (await canLaunch(_formUrl)) {
                await launch(_formUrl);
              }
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => NoticeScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.system_update,
              color: Colors.green,
            ),
            title: Text("CHECK FOR UPDATES"),
            onTap: () {
              debugPrint("Check for Updates");
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => NoticeScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            title: Text("ABOUT US"),
            onTap: () {
              debugPrint("About Us");
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => NoticeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
