import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yts_mx/JsonData/getImageData.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/utils/genreFixer.dart';
import 'package:yts_mx/utils/imageNameFixer.dart';
import 'package:yts_mx/utils/magnetLinkGenerator.dart';
import 'package:yts_mx/utils/utils.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key key, @required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          searchButton(),
        ],
      ),
      body: DisplayData(movieId: movieId),
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
}

class DisplayData extends StatelessWidget {
  final int movieId;

  const DisplayData({Key key, @required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJsonData(baseUrlMovieDetails + "movie_id=$movieId"),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map rawData = snapshot.data;
            return successResult(context, rawData);
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
                    "Sit Back & Relax - Getting Details...",
                    style: TextStyle(
                      letterSpacing: 2.0,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget successResult(BuildContext context, Map rawData) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        height: _height,
        width: _width,
        child: Image.network(
          getImageData(
              imageNameFixer(rawData["data"]["movie"]["slug"]), "background"),
          fit: BoxFit.fill,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
          frameBuilder: (BuildContext context, Widget child, int frame,
              bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          },
          errorBuilder:
              (BuildContext context, Object object, StackTrace trace) {
            return Container(
              height: _height,
              width: _width,
              color: Colors.black,
            );
          },
        ),
      ),
      ListView(
        children: [
          coverNameYear(_height, _width, rawData),
          summaryHolder(rawData["data"]["movie"]["description_full"]),
        ],
      ),
    ]);
  }

  Widget coverNameYear(double _height, double _width, Map rawData) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(15.0),
          height: _height / 3,
          width: _width / 3,
          decoration: BoxDecoration(
            border: Border.all(width: 4.0, color: Colors.white),
          ),
          child: Image.network(
            getImageData(imageNameFixer(rawData["data"]["movie"]["slug"]),
                "medium-cover"),
            fit: BoxFit.fill,
            frameBuilder: (BuildContext context, Widget child, int frame,
                bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                child: child,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            },
            errorBuilder:
                (BuildContext context, Object object, StackTrace trace) {
              return Container(
                height: _height / 3,
                width: _width / 3,
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.photo,
                        size: 60.0,
                        color: Colors.white70,
                      )),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15.0),
          width: _width / 1.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rawData["data"]["movie"]["title"],
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              Text(
                "\nYear: ${rawData["data"]["movie"]["year"]}",
                style: TextStyle(fontSize: 17.5, color: Colors.white60),
              ),
              Text(
                "Genre: " +
                    genreFixer(rawData["data"]["movie"]["genres"]) +
                    "\n",
                style: TextStyle(fontSize: 17.5, color: Colors.white60),
              ),
              Wrap(
                  children: List.generate(
                      rawData["data"]["movie"]["torrents"].length, (index) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    child: Column(
                      children: [
                        Text(rawData["data"]["movie"]["torrents"][index]
                                ["quality"] +
                            "." +
                            rawData["data"]["movie"]["torrents"][index]["type"]
                                .substring(0, 1)
                                .toUpperCase() +
                            rawData["data"]["movie"]["torrents"][index]["type"]
                                .substring(1)),
                        Text(rawData["data"]["movie"]["torrents"][index]
                            ["size"]),
                      ],
                    ),
                    onPressed: () async {
                      String _magnetUrl = magnetLinkGenerator(
                          rawData["data"]["movie"]["torrents"][index]["hash"],
                          rawData["data"]["movie"]["title_long"],
                          rawData["data"]["movie"]["torrents"][index]
                              ["quality"],
                          rawData["data"]["movie"]["torrents"][index]["type"]
                                  .substring(0, 1)
                                  .toUpperCase() +
                              rawData["data"]["movie"]["torrents"][index]
                                      ["type"]
                                  .substring(1));
                      if (await canLaunch(_magnetUrl)) {
                        await launch(_magnetUrl);
                      } else {
                        throw "Could not launch";
                      }
                    },
                  ),
                );
              })),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white60,
                      )),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 4.0, bottom: 4.0, left: 4.0, right: 15.0),
                      child: Text(
                        "${rawData["data"]["movie"]["like_count"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17.5,
                            color: Colors.white70),
                      )),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 4.0, bottom: 4.0, left: 15.0, right: 4.0),
                      child: Icon(
                        Icons.download,
                        color: Colors.white60,
                      )),
                  Container(
                      margin: const EdgeInsets.all(4.0),
                      child: Text(
                        "${rawData["data"]["movie"]["download_count"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17.5,
                            color: Colors.white70),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget summaryHolder(String synopsis) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Synopsis",
            style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          ),
          Text(
            synopsis,
            style: TextStyle(fontSize: 16.0, color: Colors.white70),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
