import 'package:flutter/material.dart';
import 'package:yts_mx/JsonData/getImageData.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/screens/movieDetailScreen.dart';
import 'package:yts_mx/utils/imageNameFixer.dart';
import 'package:yts_mx/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJsonData(baseUrlListMovies),
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
                    "Hold Tight - Getting Data...",
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
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: _height / 5,
                    width: _width / 3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.0, color: Colors.white),
                    ),
                    child: Image.network(
                      getImageData(
                          imageNameFixer(
                              rawData["data"]["movies"][index]["slug"]),
                          "medium-cover"),
                      fit: BoxFit.fill,
                      frameBuilder: (BuildContext context, Widget child,
                          int frame, bool wasSynchronouslyLoaded) {
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
                      errorBuilder: (BuildContext context, Object object,
                          StackTrace trace) {
                        return Container(
                          height: _height / 5,
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
                  Text(
                    rawData["data"]["movies"][index]["title"].length <= 15
                        ? rawData["data"]["movies"][index]["title"]
                        : "${rawData["data"]["movies"][index]["title"].substring(0, 15)}...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${rawData["data"]["movies"][index]["year"]}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                            movieId: rawData["data"]["movies"][index]["id"],
                          )));
            },
          );
        },
      ),
    );
  }
}
