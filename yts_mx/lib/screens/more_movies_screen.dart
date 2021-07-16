import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/screens/filterScreen.dart';
import 'package:yts_mx/screens/short_detail_screen.dart';
import 'package:yts_mx/utils/utils.dart';

class MoreMoviesScreen extends StatefulWidget {
  final String? title;
  final String? quality;
  final int? minimumRating;
  final String? genre;
  final String? sortBy;
  final String? orderBy;

  const MoreMoviesScreen(
      {Key? key,
        @required this.title,
        this.quality,
        this.minimumRating,
        this.genre,
        @required this.sortBy,
        this.orderBy})
      : super(key: key);

  @override
  _MoreMoviesScreenState createState() => _MoreMoviesScreenState();
}

class _MoreMoviesScreenState extends State<MoreMoviesScreen> {
  List _rawData = [];
  int _pageNumber = 1;
  int? _maxLimit;
  final ScrollController _scrollController = ScrollController();

  String? quality;
  int? minimumRating;
  String? genre;
  String? sortBy;
  String? orderBy;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.65) {
        _pageNumber += 1;
        if (_pageNumber * 20 <= _maxLimit!) {
          _getMoreData();
        }
      }
    });
    super.initState();
  }

  _getMoreData() async {
    Map tempData = await getJsonData(baseUrlListMovies,
        page: _pageNumber,
        quality: widget.quality,
        minimumRating: widget.minimumRating,
        genre: widget.genre,
        sortBy: widget.sortBy,
        orderBy: widget.orderBy);
    _rawData.addAll(tempData["data"]["movies"]);
    setState(() {});
  }

  void filterScreen(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return FilterScreen(
            title: widget.title,
            quality: quality!,
            minimumRating: minimumRating!,
            genre: genre!,
            sortBy: sortBy!,
            orderBy: orderBy!,
          );
        }
    );
  }

  void shortDetail(BuildContext context, Map temp, double height) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ShortDetailScreen(height: height, tempData: temp,);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    quality = widget.quality == null ? "All" : widget.quality;
    minimumRating = widget.minimumRating == null ? 0 : widget.minimumRating;
    genre = widget.genre == null ? "All" : widget.genre;
    sortBy = widget.sortBy == null ? "year" : widget.sortBy;
    orderBy = widget.orderBy == null ? "desc" : widget.orderBy;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
          searchButton(context),
          filterButton(context),
        ],
      ),
      body: FutureBuilder(
          future: getJsonData(baseUrlListMovies,
              page: _pageNumber,
              quality: widget.quality,
              minimumRating: widget.minimumRating,
              genre: widget.genre,
              sortBy: widget.sortBy,
              orderBy: widget.orderBy),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              Map tempData = snapshot.data!;
              _maxLimit = tempData["data"]["movie_count"];
              if (_pageNumber == 1) {
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
          }),
    );
  }

  IconButton searchButton(BuildContext context) {
    return IconButton(
      tooltip: "Search",
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/searchScreen");
      },
    );
  }

  IconButton filterButton(BuildContext context) {
    return IconButton(
      tooltip: "Filter",
      icon: const Icon(
        Icons.filter_alt,
        size: 30.0,
      ),
      onPressed: () => filterScreen(context),
    );
  }

  Widget successResult(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Scrollbar(
        radius: Radius.circular(20.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              mainAxisSpacing: _height*0.03,
            ),
            itemCount: _rawData.length + 1,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              if (index == _rawData.length) {
                return CupertinoActivityIndicator(
                  radius: 20.0,
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          _rawData[index]["medium_cover_image"],
                          fit: BoxFit.cover,
                          frameBuilder: (BuildContext context, Widget child,
                              int? frame, bool? wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded!) {
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
                              StackTrace? trace) {
                            return Center(
                              child: Image.asset(
                                "images/logo-YTS.png",
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      onTap: () => shortDetail(context, _rawData[index], _height),
                    ),
                  ),
                  Text(
                    _rawData[index]["title"].length <= 12
                        ? _rawData[index]["title"]
                        : "${_rawData[index]["title"].substring(0, 12)}...",
                  ),
                  Text(
                    "${_rawData[index]["year"]}",
                  ),
                  // Divider(thickness: 1.0,)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
