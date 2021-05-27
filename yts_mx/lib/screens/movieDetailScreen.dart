import 'package:flutter/material.dart';
import 'package:yts_mx/JsonData/getImageData.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/utils/genreFixer.dart';
import 'package:yts_mx/utils/imageNameFixer.dart';
import 'package:yts_mx/utils/utils.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailScreen({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          searchButton(),
        ],
      ),
      body: DisplayData(movieId: movieId,),
    );
  }
  
  IconButton searchButton() {
    return IconButton(
      icon: Icon(Icons.search, size: 30.0,),
      onPressed: () => debugPrint("Search"),
    );
  }
}

class DisplayData extends StatelessWidget {
  final int movieId;
  const DisplayData({Key key, this.movieId}) : super(key: key);

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
        }
    );
  }

  Widget successResult(BuildContext context, Map rawData) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
        height: _height,
        width: _width,
        child: Image.network(
          getImageData(imageNameFixer(rawData["data"]["movie"]["slug"]), "background"),
          fit: BoxFit.fill,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
          frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
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
          errorBuilder: (BuildContext context, Object object, StackTrace trace) {
            return Container(
              height: _height/5,
              width: _width/3,
              child: Center(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  Icon(Icons.photo, size: 60.0, color: Colors.white70,)
                ),
              ),
            );
          },
        ),
      ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(15.0),
                  height: _height/3,
                  width: _width/3,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4.0, color: Colors.white),
                  ),
                  child: Image.network(
                    getImageData(imageNameFixer(rawData["data"]["movie"]["slug"]), "medium-cover"),
                    fit: BoxFit.fill,
                    frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
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
                    errorBuilder: (BuildContext context, Object object, StackTrace trace) {
                      return Container(
                        height: _height/3,
                        width: _width/3,
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child:  Icon(Icons.photo, size: 60.0, color: Colors.white70,)
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  width: _width/1.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rawData["data"]["movie"]["title"], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),),
                      Text("\nYear: ${rawData["data"]["movie"]["year"]}", style: TextStyle(fontSize: 17.5, color: Colors.white70),),
                      Text("Genre: " + genreFixer(rawData["data"]["movie"]["genres"]) + "\n", style: TextStyle(fontSize: 17.5, color: Colors.white70),),
                      Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                                onPressed: () => debugPrint("Pressed"),
                                child: Text("720p")
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                                onPressed: () => debugPrint("Pressed"),
                                child: Text("1080p")
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                                onPressed: () => debugPrint("Pressed"),
                                child: Text("2160p")
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                                onPressed: () => debugPrint("Pressed"),
                                child: Text("3D")
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    ]
    );
  }
}



