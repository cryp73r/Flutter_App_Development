import 'package:flutter/material.dart';
import 'package:yts_mx/screens/appDrawer.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: contentHolder(context),
      drawer: appDrawer(context),
    );
  }

  Widget contentHolder(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "images/logo-YTS.png",
          fit: BoxFit.fill,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(15.0),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Text(
            "This app is a simple yts.mx Search Engine. The best thing about this app is that, no matter who is your ISP (Internet Service Provider) or whether yts.mx is blocked by your ISP, the app will work absolutely fine. No need to install any VPN.\n",
            textAlign: TextAlign.justify,
            style: normalBody(),
          ),
          Text(
            "Note: It is not an Official App by `yts.mx`. The app just uses yts.mx api at backend to get data, Officially provided by them.\n",
            textAlign: TextAlign.justify,
            style: importantBody(),
          ),
          Text(
            "We respect Privacy of our User, so neither we collect any information from user nor we ask for any extra permission from User. Even search history are not stored anywhere, not even locally on device.\n",
            textAlign: TextAlign.justify,
            style: normalBody(),
          ),
          Text(
            "All you need is an Active and Good Internet Connection and you are good to GO.\n",
            textAlign: TextAlign.justify,
            style: normalBody(),
          ),
          Text(
            "Talking about your IP Address, yts.mx will never get to know about it. Thanks to our backend server, who requests for data on your behalf hence your IP is also 🔐 (Secured).\n",
            textAlign: TextAlign.justify,
            style: normalBody(),
          ),
          Text(
            "Regards",
            textAlign: TextAlign.justify,
            style: normalBody(),
          ),
          Text(
            "CRYP73R",
            textAlign: TextAlign.justify,
            style: normalBody(),
          ),
        ]),
      ),
    ]);
  }

  TextStyle normalBody() {
    return TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    );
  }

  TextStyle importantBody() {
    return TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
      color: Colors.white70,
    );
  }
}
