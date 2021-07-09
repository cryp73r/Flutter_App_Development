import 'package:flutter/material.dart';
import 'package:yts_mx/screens/home.dart';

class FilterScreen extends StatefulWidget {
  final String? quality;
  final int? minimumRating;
  final String? genre;
  final String? sortBy;
  final String? orderBy;

  const FilterScreen(
      {Key? key,
      this.quality,
      this.minimumRating,
      this.genre,
      this.sortBy,
      this.orderBy})
      : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? quality;
  int? minimumRating;
  String? genre;
  String? sortBy;
  String? orderBy;

  bool _qualityEnabled = true;
  bool _minimumRatingEnabled = false;
  bool _genreEnabled = false;
  bool _sortByEnabled = false;
  bool _orderByEnabled = false;

  @override
  void initState() {
    quality = widget.quality == null ? "All" : widget.quality;
    minimumRating = widget.minimumRating == null ? 0 : widget.minimumRating;
    genre = widget.genre == null ? "All" : widget.genre;
    sortBy = widget.sortBy == null ? "year" : widget.sortBy;
    orderBy = widget.orderBy == null ? "desc" : widget.orderBy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Column(children: [
      Expanded(
        child: Row(
          children: [
            Container(
              height: (2 * _height) / 3,
              width: (1.15 * _width) / 2.7,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ListTile(
                    title: const Text("QUALITY"),
                    leading: const Icon(Icons.high_quality_rounded),
                    selected: _qualityEnabled,
                    onTap: () {
                      _qualityEnabled = true;
                      _minimumRatingEnabled = false;
                      _genreEnabled = false;
                      _sortByEnabled = false;
                      _orderByEnabled = false;
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: const Text("MINIMUM RATING"),
                    leading: const Icon(Icons.star),
                    selected: _minimumRatingEnabled,
                    onTap: () {
                      _qualityEnabled = false;
                      _minimumRatingEnabled = true;
                      _genreEnabled = false;
                      _sortByEnabled = false;
                      _orderByEnabled = false;
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: const Text("GENRE"),
                    leading: const Icon(Icons.theater_comedy),
                    selected: _genreEnabled,
                    onTap: () {
                      _qualityEnabled = false;
                      _minimumRatingEnabled = false;
                      _genreEnabled = true;
                      _sortByEnabled = false;
                      _orderByEnabled = false;
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: const Text("SORT BY"),
                    leading: const Icon(Icons.sort_rounded),
                    selected: _sortByEnabled,
                    onTap: () {
                      _qualityEnabled = false;
                      _minimumRatingEnabled = false;
                      _genreEnabled = false;
                      _sortByEnabled = true;
                      _orderByEnabled = false;
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: const Text("ORDER BY"),
                    leading: const Icon(Icons.bookmark_border),
                    selected: _orderByEnabled,
                    onTap: () {
                      _qualityEnabled = false;
                      _minimumRatingEnabled = false;
                      _genreEnabled = false;
                      _sortByEnabled = false;
                      _orderByEnabled = true;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: (2 * _height) / 3,
              width: (0.05 * _width) / 2.7,
              color: Colors.green,
            ),
            _qualityEnabled
                ? qualityContainer(_height, _width)
                : _minimumRatingEnabled
                    ? ratingContainer(_height, _width)
                    : _genreEnabled
                        ? genreContainer(_height, _width)
                        : _sortByEnabled
                            ? sortByContainer(_height, _width)
                            : _orderByEnabled
                                ? orderByContainer(_height, _width)
                                : Container(),
          ],
        ),
      ),
      textButtonHolder(),
    ]);
  }

  Widget textButtonHolder() {
    bool _enabled = true;
    if (quality=="All")
      if (minimumRating==0)
        if (genre=="All")
          if (sortBy=="year")
            if (orderBy=="desc")
              _enabled = false;
    return Container(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Text(
              "RESET",
              style: TextStyle(fontSize: 16.0),
            ),
            onPressed: _enabled?() {
              setState(() {
                quality = "All";
                minimumRating = 0;
                genre = "All";
                sortBy = "year";
                orderBy = "desc";

                _qualityEnabled = true;
                _minimumRatingEnabled = false;
                _genreEnabled = false;
                _sortByEnabled = false;
                _orderByEnabled = false;
              });
            }:null,
          ),
          TextButton(
            child: Text(
              "CONFIRM",
              style: TextStyle(fontSize: 16.0),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
                            quality: quality,
                            minimumRating: minimumRating,
                            genre: genre,
                            sortBy: sortBy,
                            orderBy: orderBy,
                          )),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget qualityContainer(double _height, double _width) {
    return Container(
      height: (2 * _height) / 3,
      width: (1.5 * _width) / 2.7,
      child: ListView(
        children: [
          ListTile(
            title: const Text("All"),
            leading: Radio(
                value: "All",
                groupValue: quality,
                onChanged: (String? value) {
                  setState(() {
                    quality = value;
                  });
                }),
            selected: quality == "All",
          ),
          ListTile(
            title: const Text("720p"),
            leading: Radio(
              value: "720p",
              groupValue: quality,
              onChanged: (String? value) {
                setState(() {
                  quality = value;
                });
              },
            ),
            selected: quality == "720p",
          ),
          ListTile(
            title: const Text("1080p"),
            leading: Radio(
              value: "1080p",
              groupValue: quality,
              onChanged: (String? value) {
                setState(() {
                  quality = value;
                });
              },
            ),
            selected: quality == "1080p",
          ),
          ListTile(
            title: const Text("2160p"),
            leading: Radio(
              value: "2160p",
              groupValue: quality,
              onChanged: (String? value) {
                setState(() {
                  quality = value;
                });
              },
            ),
            selected: quality == "2160p",
          ),
          ListTile(
            title: const Text("3D"),
            leading: Radio(
              value: "3D",
              groupValue: quality,
              onChanged: (String? value) {
                setState(() {
                  quality = value;
                });
              },
            ),
            selected: quality == "3D",
          ),
        ],
      ),
    );
  }

  Widget ratingContainer(double _height, double _width) {
    return Container(
      height: (2 * _height) / 3,
      width: (1.5 * _width) / 2.7,
      child: ListView(
        children: [
          ListTile(
            title: const Text("0 and above"),
            leading: Radio(
                value: 0,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 0,
          ),
          ListTile(
            title: const Text("1 and above"),
            leading: Radio(
                value: 1,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 1,
          ),
          ListTile(
            title: const Text("2 and above"),
            leading: Radio(
                value: 2,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 2,
          ),
          ListTile(
            title: const Text("3 and above"),
            leading: Radio(
                value: 3,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 3,
          ),
          ListTile(
            title: const Text("4 and above"),
            leading: Radio(
                value: 4,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 4,
          ),
          ListTile(
            title: const Text("5 and above"),
            leading: Radio(
                value: 5,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 5,
          ),
          ListTile(
            title: const Text("6 and above"),
            leading: Radio(
                value: 6,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 6,
          ),
          ListTile(
            title: const Text("7 and above"),
            leading: Radio(
                value: 7,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 7,
          ),
          ListTile(
            title: const Text("8 and above"),
            leading: Radio(
                value: 8,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 8,
          ),
          ListTile(
            title: const Text("9 and above"),
            leading: Radio(
                value: 9,
                groupValue: minimumRating,
                onChanged: (int? value) {
                  setState(() {
                    minimumRating = value;
                  });
                }),
            selected: minimumRating == 9,
          ),
        ],
      ),
    );
  }

  Widget genreContainer(double _height, double _width) {
    return Container(
      height: (2 * _height) / 3,
      width: (1.5 * _width) / 2.7,
      child: ListView(
        children: [
          ListTile(
            title: const Text("All"),
            leading: Radio(
                value: "All",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "All",
          ),
          ListTile(
            title: const Text("Action"),
            leading: Radio(
                value: "Action",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Action",
          ),
          ListTile(
            title: const Text("Adventure"),
            leading: Radio(
                value: "Adventure",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Adventure",
          ),
          ListTile(
            title: const Text("Animation"),
            leading: Radio(
                value: "Animation",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Animation",
          ),
          ListTile(
            title: const Text("Biography"),
            leading: Radio(
                value: "Biography",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Biography",
          ),
          ListTile(
            title: const Text("Comedy"),
            leading: Radio(
                value: "Comedy",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Comedy",
          ),
          ListTile(
            title: const Text("Crime"),
            leading: Radio(
                value: "Crime",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Crime",
          ),
          ListTile(
            title: const Text("Documentary"),
            leading: Radio(
                value: "Documentary",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Documentary",
          ),
          ListTile(
            title: const Text("Drama"),
            leading: Radio(
                value: "Drama",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Drama",
          ),
          ListTile(
            title: const Text("Family"),
            leading: Radio(
                value: "Family",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Family",
          ),
          ListTile(
            title: const Text("Fantasy"),
            leading: Radio(
                value: "Fantasy",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Fantasy",
          ),
          ListTile(
            title: const Text("Film Noir"),
            leading: Radio(
                value: "Film Noir",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Film Noir",
          ),
          ListTile(
            title: const Text("History"),
            leading: Radio(
                value: "History",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "History",
          ),
          ListTile(
            title: const Text("Horror"),
            leading: Radio(
                value: "Horror",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Horror",
          ),
          ListTile(
            title: const Text("Music"),
            leading: Radio(
                value: "Music",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Music",
          ),
          ListTile(
            title: const Text("Musical"),
            leading: Radio(
                value: "Musical",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Musical",
          ),
          ListTile(
            title: const Text("Mystery"),
            leading: Radio(
                value: "Mystery",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Mystery",
          ),
          ListTile(
            title: const Text("Romance"),
            leading: Radio(
                value: "Romance",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Romance",
          ),
          ListTile(
            title: const Text("Sci-Fi"),
            leading: Radio(
                value: "Sci-Fi",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Sci-Fi",
          ),
          ListTile(
            title: const Text("Short Film"),
            leading: Radio(
                value: "Short Film",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Short Film",
          ),
          ListTile(
            title: const Text("Sport"),
            leading: Radio(
                value: "Sport",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Sport",
          ),
          ListTile(
            title: const Text("Superhero"),
            leading: Radio(
                value: "Superhero",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Superhero",
          ),
          ListTile(
            title: const Text("Thriller"),
            leading: Radio(
                value: "Thriller",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Thriller",
          ),
          ListTile(
            title: const Text("War"),
            leading: Radio(
                value: "War",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "War",
          ),
          ListTile(
            title: const Text("Western"),
            leading: Radio(
                value: "Western",
                groupValue: genre,
                onChanged: (String? value) {
                  setState(() {
                    genre = value;
                  });
                }),
            selected: genre == "Western",
          ),
        ],
      ),
    );
  }

  Widget sortByContainer(double _height, double _width) {
    return Container(
      height: (2 * _height) / 3,
      width: (1.5 * _width) / 2.7,
      child: ListView(
        children: [
          ListTile(
            title: const Text("Title"),
            leading: Radio(
                value: "title",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "title",
          ),
          ListTile(
            title: const Text("Year"),
            leading: Radio(
                value: "year",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "year",
          ),
          ListTile(
            title: const Text("Rating"),
            leading: Radio(
                value: "rating",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "rating",
          ),
          ListTile(
            title: const Text("Peers"),
            leading: Radio(
                value: "peers",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "peers",
          ),
          ListTile(
            title: const Text("Seeds"),
            leading: Radio(
                value: "seeds",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "seeds",
          ),
          ListTile(
            title: const Text("Downloads"),
            leading: Radio(
                value: "download_count",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "download_count",
          ),
          ListTile(
            title: const Text("Likes"),
            leading: Radio(
                value: "like_count",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "like_count",
          ),
          ListTile(
            title: const Text("Date Added"),
            leading: Radio(
                value: "date_added",
                groupValue: sortBy,
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value;
                  });
                }),
            selected: sortBy == "date_added",
          ),
        ],
      ),
    );
  }

  Widget orderByContainer(double _height, double _width) {
    return Container(
      height: (2 * _height) / 3,
      width: (1.5 * _width) / 2.7,
      child: ListView(
        children: [
          ListTile(
            title: const Text("Descending"),
            leading: Radio(
                value: "desc",
                groupValue: orderBy,
                onChanged: (String? value) {
                  setState(() {
                    orderBy = value;
                  });
                }),
            selected: orderBy == "desc",
          ),
          ListTile(
            title: const Text("Ascending"),
            leading: Radio(
                value: "asc",
                groupValue: orderBy,
                onChanged: (String? value) {
                  setState(() {
                    orderBy = value;
                  });
                }),
            selected: orderBy == "asc",
          ),
        ],
      ),
    );
  }
}
