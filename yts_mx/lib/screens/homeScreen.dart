import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yts_mx/JsonData/getImageData.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/screens/short_detail_screen.dart';
import 'package:yts_mx/utils/imageNameFixer.dart';
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

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            carouselHolder(_height),
            movieHolder(context, _height, "Latest Movies", "year"),
            movieHolder(context, _height, "Trending Now", "date_added"),
            movieHolder(context, _height, "Highly Rated", "rating"),
            movieHolder(context, _height, "Most Downloaded", "download_count"),
            movieHolder(context, _height, "Most Liked", "like_count"),
          ],
        ),
      ),
    );
  }

  Widget movieHolder(BuildContext context, double height, String title, String sortBy) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(child: Text(title)),
              TextButton(onPressed: () {}, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("More"), Icon(Icons.keyboard_arrow_right)],)),
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
                                        getImageData(imageNameFixer(tempData["data"]["movies"][index]["slug"]),
                                            "medium-cover"),
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
          limit: 10,
        ),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map tempData = snapshot.data!;
            return Column(
              children: [
                CarouselSlider.builder(
                    itemCount: tempData["data"]["movies"].length,
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      return InkWell(
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(getImageData(imageNameFixer(tempData["data"]["movies"][index]["slug"]),
                                      "medium-cover")),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                width: 300.0,
                                color: Colors.black54,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                child: Text(tempData["data"]["movies"][index]["title_long"], style: const TextStyle(
                                  fontSize: 26.0,
                                  color: Colors.white,
                                ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () => shortDetail(context, tempData["data"]["movies"][index], height),
                      );
                    },
                    options: CarouselOptions(
                      height: height / 3.3,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                ),
              ],
      );
    }
          return CircularProgressIndicator();
      }
    );
  }
}
