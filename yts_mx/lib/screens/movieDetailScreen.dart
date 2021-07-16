import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yts_mx/JsonData/getJsonData.dart';
import 'package:yts_mx/screens/appDrawer.dart';
import 'package:yts_mx/screens/short_detail_screen.dart';
import 'package:yts_mx/utils/magnetLinkGenerator.dart';
import 'package:yts_mx/utils/utils.dart';

class MovieDetailScreen extends StatelessWidget {
  final int? movieId;
  final String? ytTrailerCode;

  const MovieDetailScreen({Key? key, @required this.movieId, @required this.ytTrailerCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          searchButton(context),
        ],
      ),
      body: DisplayData(movieId: movieId, ytTrailerCode: ytTrailerCode,),
      drawer: appDrawer(context),
    );
  }

  IconButton searchButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/searchScreen");
      },
    );
  }
}

class DisplayData extends StatefulWidget {
  final int? movieId;
  final String? ytTrailerCode;

  const DisplayData({Key? key, @required this.movieId, @required this.ytTrailerCode}) : super(key: key);

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {

  bool showMagnet=false;
  String? magnetUrl;
  bool enableButton=true;
  late YoutubePlayerController _ytController;
  final ScrollController _scrollController = ScrollController();
  bool muted = true;

  @override
  void initState() {
    _ytController = YoutubePlayerController(
      initialVideoId: widget.ytTrailerCode!,
      flags: YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: true,
        autoPlay: true,
        mute: true,
        loop: true,
        useHybridComposition: false,
      ),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent*0.25)
        _ytController.pause();
      else
        _ytController.play();
    });
    super.initState();
  }

  void shortDetail(BuildContext context, Map temp, double height) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ShortDetailScreen(height: height, tempData: temp,);
        }
    );
  }

  String buttonName (String quality, String type, String size) {
    if (type.length!=3) return "$quality.${type.substring(0, 1).toUpperCase()+type.substring(1, 3)+type.substring(3, 4).toUpperCase()+type.substring(4)} ($size)";
    else return "$quality.${type.toUpperCase()} ($size)";
  }

  String torrentName (String quality, String type) {
    if (type.length!=3) return "$quality.${type.substring(0, 1).toUpperCase()+type.substring(1, 3)+type.substring(3, 4).toUpperCase()+type.substring(4)}";
    else return "$quality.${type.toUpperCase()}";
  }

  void downloadAction(String hash, String movieName, String qualityType) async {
    magnetUrl = magnetLinkGenerator(hash, movieName, qualityType);
    if (await canLaunch(magnetUrl!)) {
      await launch(magnetUrl!);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Torrent Client Not Found!"),
              content: const Text('Press "CANCEL" to Reveal & Copy Magnet URL\nPress "OK" to Search for Torrent Client & Install'),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        showMagnet=true;
                        enableButton=true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("CANCEL")),
                TextButton(
                    onPressed: () async {
                      String searchUrl = "https://play.google.com/store/search?q=torrent%20client&c=apps";
                      if (await canLaunch(searchUrl)) {
                        await launch(searchUrl);
                      }
                      else {
                        throw "Could not launch";
                      }
                      setState(() {
                        showMagnet=false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK")),
              ],
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJsonData(baseUrlMovieDetails, movieId: widget.movieId, withImages: true, withCast: true),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map rawData = snapshot.data!;
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
          rawData["data"]["movie"]["background_image"],
          fit: BoxFit.fill,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool? wasSynchronouslyLoaded) {
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
          errorBuilder:
              (BuildContext context, Object object, StackTrace? trace) {
            return Container(
              height: _height,
              width: _width,
              color: Colors.black,
            );
          },
        ),
      ),
      ListView(
        controller: _scrollController,
        children: [
          ytTrailerHolder(rawData),
          detailsHolder(_height, _width, rawData),
        ],
      ),
    ]);
  }

  Widget ytTrailerHolder(Map tempData) {
    return YoutubePlayer(
      controller: _ytController,
      showVideoProgressIndicator: true,
      bottomActions: [
        if (muted) IconButton(onPressed: () {
          _ytController.unMute();
          muted = false;
          setState(() {});
        }, icon: Icon(Icons.volume_off))
        else IconButton(
            onPressed: () {
              _ytController.mute();
              muted = true;
              setState(() {});
              },
            icon: Icon(Icons.volume_up))
      ],
    );
  }

  Widget detailsHolder(double height, double width, Map tempData) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tempData["data"]["movie"]["title"], style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.justify, softWrap: true, overflow: TextOverflow.fade,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("• ${tempData["data"]["movie"]["year"]}"),
              Text("• ${tempData["data"]["movie"]["language"]}".toUpperCase()),
              if ((tempData["data"]["movie"]["runtime"]/60).toString().substring(0, 1)!="0") Text("• ${(tempData["data"]["movie"]["runtime"]/60).toString().substring(0, 1)}h ${tempData["data"]["movie"]["runtime"]%60}m"),
              if ((tempData["data"]["movie"]["runtime"]/60).toString().substring(0, 1)=="0") Text("• ${tempData["data"]["movie"]["runtime"]} min"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (tempData["data"]["movie"]["rating"]!=0) Text("• IMDB Rating: ${tempData["data"]["movie"]["rating"]}/10"),
              if (tempData["data"]["movie"]["rating"]==0) Text("• IMDB Rating: N/A"),
              if (tempData["data"]["movie"]["mpa_rating"]!="") Text("• MPA Rating: ${tempData["data"]["movie"]["mpa_rating"]}"),
              if (tempData["data"]["movie"]["mpa_rating"]=="") Text("• MPA Rating: N/A"),
            ],
          ),
          if (tempData["data"]["movie"]["genres"].length<=5) Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tempData["data"]["movie"]["genres"].length, (index) => Text("• ${tempData["data"]["movie"]["genres"][index]}")),
          ),
          if (tempData["data"]["movie"]["genres"].length>5) Row(
            children: [
              SizedBox(
                width: width*0.95,
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(5, (index) => Text("• ${tempData["data"]["movie"]["genres"][index]}")),),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(tempData["data"]["movie"]["genres"].length-5, (index) => Text("• ${tempData["data"]["movie"]["genres"][5+index]}")),),
                ],),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("• Downloads: ${tempData["data"]["movie"]["download_count"]}"),
              Text("• Likes: ${tempData["data"]["movie"]["like_count"]}"),
            ],
          ),
          if (showMagnet) Card(child: ListTile(
            leading: const Text("Magnet URL:"),
            title: Text(magnetUrl!),
            trailing: TextButton(onPressed: enableButton?() {
              Clipboard.setData(ClipboardData(text: magnetUrl!));
              setState(() {
                enableButton=false;
              });
            }:null, child: Text(enableButton?"COPY":"COPIED")),
          ),),
          Column(
            children: List.generate(tempData["data"]["movie"]["torrents"].length, (index) {
              if (tempData["data"]["movie"]["torrents"][index]["quality"]=="720p") return SizedBox(width: width, child: ElevatedButton.icon(onPressed: () => downloadAction(tempData["data"]["movie"]["torrents"][index]["hash"], tempData["data"]["movie"]["title_long"], torrentName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"])), icon: Icon(Icons.high_quality), label: Text(buttonName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"], tempData["data"]["movie"]["torrents"][index]["size"]))));
              else if (tempData["data"]["movie"]["torrents"][index]["quality"]=="1080p") return SizedBox(width: width, child: ElevatedButton.icon(onPressed: () => downloadAction(tempData["data"]["movie"]["torrents"][index]["hash"], tempData["data"]["movie"]["title_long"], torrentName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"])), icon: Icon(Icons.hd), label: Text(buttonName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"], tempData["data"]["movie"]["torrents"][index]["size"]))));
              else if (tempData["data"]["movie"]["torrents"][index]["quality"]=="2160p") return SizedBox(width: width, child: ElevatedButton.icon(onPressed: () => downloadAction(tempData["data"]["movie"]["torrents"][index]["hash"], tempData["data"]["movie"]["title_long"], torrentName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"])), icon: Icon(Icons.four_k), label: Text(buttonName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"], tempData["data"]["movie"]["torrents"][index]["size"]))));
              else return SizedBox(width: width, child: ElevatedButton.icon(onPressed: () => downloadAction(tempData["data"]["movie"]["torrents"][index]["hash"], tempData["data"]["movie"]["title_long"], torrentName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"])), icon: Icon(Icons.threed_rotation), label: Text(buttonName(tempData["data"]["movie"]["torrents"][index]["quality"], tempData["data"]["movie"]["torrents"][index]["type"], tempData["data"]["movie"]["torrents"][index]["size"]))));
            }),
          ),
          Text(tempData["data"]["movie"]["description_full"], textAlign: TextAlign.justify, overflow: TextOverflow.fade, softWrap: true,),
          SizedBox(
            width: width,
            height: height / 3.3,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      tempData["data"]["movie"]["medium_screenshot_image${index+1}"],
                      fit: BoxFit.cover,
                      frameBuilder: (BuildContext context, Widget child, int? frame,
                          bool? wasSynchronouslyLoaded) {
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
                      errorBuilder:
                          (BuildContext context, Object object, StackTrace? trace) {
                        return Image.asset("images/logo-YTS.png",);
                      },
                    ),
                  );
                }
                ),
          ),
          if (tempData["data"]["movie"]["cast"]!=null) Column(
            children: List.generate(tempData["data"]["movie"]["cast"].length, (index) {
              return Card(
                child: ListTile(
                  leading: ClipRRect(borderRadius: BorderRadius.circular(4.0), child: Image.network(
                    (tempData["data"]["movie"]["cast"][index]["url_small_image"]!=null)?tempData["data"]["movie"]["cast"][index]["url_small_image"]:"https://google.com",
                    fit: BoxFit.cover,
                      frameBuilder: (BuildContext context, Widget child, int? frame,
                          bool? wasSynchronouslyLoaded) {
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
                      errorBuilder:
                          (BuildContext context, Object object, StackTrace? trace) {
                        return Icon(Icons.person, size: 56.0,);
                      }
                  )),
                  title: Text(tempData["data"]["movie"]["cast"][index]["name"]),
                  trailing: Text(tempData["data"]["movie"]["cast"][index]["character_name"]),
                ),);
            }),
          ),
          SizedBox(height: 10.0,),
          FutureBuilder(
            future: getJsonData(baseUrlMovieSuggestions, movieId: widget.movieId),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasData) {
                Map _tempData = snapshot.data!;
                return CarouselSlider(
                    items: List.generate(2, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: imageLoader(_tempData, index),
                                  ),
                                  onTap: () => shortDetail(context, _tempData["data"]["movies"][index], height),
                                ),
                              ),
                              Text(_tempData["data"]["movies"][index]["title"].length <= 12
                                  ? _tempData["data"]["movies"][index]["title"]
                                  : "${_tempData["data"]["movies"][index]["title"].substring(0, 12)}..."),
                              Text("${_tempData["data"]["movies"][index]["year"]}")
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: imageLoader(_tempData, index+2),
                                  ),
                                  onTap: () => shortDetail(context, _tempData["data"]["movies"][index+2], height),
                                ),
                              ),
                              Text(_tempData["data"]["movies"][index+2]["title"].length <= 12
                                  ? _tempData["data"]["movies"][index+2]["title"]
                                  : "${_tempData["data"]["movies"][index+2]["title"].substring(0, 12)}..."),
                              Text("${_tempData["data"]["movies"][index+2]["year"]}")
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
              return SizedBox();
            }
          ),
        ],
      ),
    );
  }

  Widget imageLoader(Map tempData, int index) {
    return Image.network(
      tempData["data"]["movies"][index]["medium_cover_image"],
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
