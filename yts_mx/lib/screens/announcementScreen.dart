import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/screens/appDrawer.dart';
import 'package:yts_mx/utils/utils.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcements"),
        centerTitle: true,
      ),
      drawer: appDrawer(context),
      body: FutureBuilder(
        future: getJsonData(announcementUrl),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map rawData = snapshot.data!;
            return successWidget(context, rawData);
          }
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  ),
                  Text(
                    "Sit Tight & Relax - Getting Announcements...",
                    style: TextStyle(
                      letterSpacing: 2.0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget successWidget(BuildContext context, Map rawData) {
    return Stack(
      children: [
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
        rawData["data"].length == 0
            ? Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "No Announcements Yet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Flexible(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(8.0),
                            reverse: false,
                            itemCount: rawData["data"].length,
                            itemBuilder: (_, int index) {
                              return Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Card(
                                    color: Colors.white10,
                                    child: ListTile(
                                      title: Text(
                                        rawData["data"][index]["department"],
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.5),
                                      ),
                                      subtitle: Text(
                                        "Dated: ${DateFormat.yMMMMd('en_US').format(DateTime(int.parse(rawData["data"][index]["date"].substring(0, 4)), int.parse(rawData["data"][index]["date"].substring(5, 7)), int.parse(rawData["data"][index]["date"].substring(8, 10))))}\n\n" +
                                            rawData["data"][index]["message"] +
                                            "\n\n" +
                                            rawData["data"][index]
                                                ["designation"] +
                                            "\n" +
                                            rawData["data"][index]
                                                ["authority_name"],
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 5.0,
                                  )
                                ],
                              );
                            })),
                    Divider(
                      height: 5.0,
                    )
                  ],
                ),
              )
      ],
    );
  }
}
