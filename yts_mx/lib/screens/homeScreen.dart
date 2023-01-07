import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/screens/more_movies_screen.dart';
import 'package:yts_mx/screens/short_detail_screen.dart';
import 'package:yts_mx/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void shortDetail(BuildContext context, Map temp, double height) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ShortDetailScreen(height: height, tempData: temp,);
        }
    );
  }

  void moreButtonAction(BuildContext context, String title, String sortBy) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MoreMoviesScreen(title: title, sortBy: sortBy)));
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            carouselHolder(_height),
            movieHolder(context, _height, "Latest Movies", "year", themeData),
            movieHolder(context, _height, "Trending Now", "date_added", themeData),
            movieHolder(context, _height, "Highly Rated", "rating", themeData),
            movieHolder(context, _height, "Most Downloaded", "download_count", themeData),
            movieHolder(context, _height, "Most Liked", "like_count", themeData),
          ],
        ),
      ),
    );
  }

  Widget movieHolder(BuildContext context, double height, String title, String sortBy, ThemeData themeData) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(child: Text(title, style: themeData.textTheme.bodyText1,)),
              TextButton(onPressed: () => moreButtonAction(context, title, sortBy), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("More"), Icon(Icons.keyboard_arrow_right)],)),
            ],
          ),
        ),
        FutureBuilder(
            future: getJsonData(baseUrlListMovies,
                page: 1,
              sortBy: sortBy,
            ),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasData) {
                Map tempData = snapshot.data!;
                return SizedBox(
                  height: height / 3.3,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: tempData["data"]["movies"].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                        baseUrlImageData+tempData["data"]["movies"][index]["medium_cover_image"],
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
                                  onTap: () => shortDetail(context, tempData["data"]["movies"][index], height),
                                ),
                              ),
                              Text(tempData["data"]["movies"][index]["title"].length <= 12
                                  ? tempData["data"]["movies"][index]["title"]
                                  : "${tempData["data"]["movies"][index]["title"].substring(0, 12)}..."),
                              Text("${tempData["data"]["movies"][index]["year"]}")
                            ],
                          ),
                        );
                      }
                  ),
                );
              }
              return LinearProgressIndicator();
          }
        ),
      ],
    );
  }

  Widget carouselHolder(double height) {
    return FutureBuilder(
        future: getJsonData(baseUrlListMovies,
          page: 1,
          quality: "2160p",
          sortBy: "year",
        ),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map tempData = snapshot.data!;
            return CarouselSlider(
                items: List.generate(tempData["data"]["movies"].length~/2, (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: imageLoader(tempData, index),
                              ),
                              onTap: () => shortDetail(context, tempData["data"]["movies"][index], height),
                            ),
                          ),
                          Text(tempData["data"]["movies"][index]["title"].length <= 12
                              ? tempData["data"]["movies"][index]["title"]
                              : "${tempData["data"]["movies"][index]["title"].substring(0, 12)}..."),
                          Text("${tempData["data"]["movies"][index]["year"]}")
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: imageLoader(tempData, index+10),
                              ),
                              onTap: () => shortDetail(context, tempData["data"]["movies"][index+10], height),
                            ),
                          ),
                          Text(tempData["data"]["movies"][index+10]["title"].length <= 12
                              ? tempData["data"]["movies"][index+10]["title"]
                              : "${tempData["data"]["movies"][index+10]["title"].substring(0, 12)}..."),
                          Text("${tempData["data"]["movies"][index+10]["year"]}")
                        ],
                      )
                    ],
                  );
                }),
                options: CarouselOptions(
                  height: height / 3.3,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 9 / 16,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ));
          }
          return CircularProgressIndicator();
        }
    );
  }

  Widget imageLoader(Map tempData, int index) {
    return Image.network(
      baseUrlImageData+tempData["data"]["movies"][index]["medium_cover_image"],
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
    );
  }
}
