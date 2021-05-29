import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yts_mx/JsonData/getImageData.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/screens/movieDetailScreen.dart';
import 'package:yts_mx/utils/imageNameFixer.dart';
import 'package:yts_mx/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _rawData = [];
  int _pageNumber = 1;
  int _maxLimit;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels==_scrollController.position.maxScrollExtent) {
        _pageNumber+=1;
        if (_pageNumber*20<=_maxLimit) {
          _getMoreData();
        }
      }
    });
    super.initState();
  }

  _getMoreData() async {
    Map tempData = await getJsonData(baseUrlListMovies, page: _pageNumber);
      _rawData.addAll(tempData["data"]["movies"]);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJsonData(baseUrlListMovies, page: _pageNumber),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map tempData = snapshot.data;
            _maxLimit = tempData["data"]["movie_count"];
            if (_pageNumber==1) {
              _rawData = tempData["data"]["movies"];
            }
            return successResult(context);
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

  Widget successResult(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      semanticsLabel: "Refreshing...",
      onRefresh: _refreshData,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: _rawData.length+1,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            if (index==_rawData.length) {
              return CupertinoActivityIndicator(radius: 20.0,);
            }
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
                                _rawData[index]["slug"]),
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
                      _rawData[index]["title"].length <= 15
                          ? _rawData[index]["title"]
                          : "${_rawData[index]["title"].substring(0, 15)}...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${_rawData[index]["year"]}",
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
                              movieId: _rawData[index]["id"],
                            )));
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _rawData.clear();
      _pageNumber = 1;
    });
  }
}
