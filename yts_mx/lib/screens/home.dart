import 'package:flutter/material.dart';
import 'package:yts_mx/screens/appDrawer.dart';
import 'package:yts_mx/screens/filterScreen.dart';
import 'package:yts_mx/screens/homeScreen.dart';

class Home extends StatefulWidget {
  final String quality;
  final int minimumRating;
  final String genre;
  final String sortBy;
  final String orderBy;

  const Home(
      {Key key,
      this.quality,
      this.minimumRating,
      this.genre,
      this.sortBy,
      this.orderBy})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _activated = false;

  String quality;
  int minimumRating;
  String genre;
  String sortBy;
  String orderBy;

  @override
  Widget build(BuildContext context) {
    quality = widget.quality == null ? "All" : widget.quality;
    minimumRating = widget.minimumRating == null ? 0 : widget.minimumRating;
    genre = widget.genre == null ? "All" : widget.genre;
    sortBy = widget.sortBy == null ? "year" : widget.sortBy;
    orderBy = widget.orderBy == null ? "desc" : widget.orderBy;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/logo-YTS.png",
        ),
        actions: [
          searchButton(context),
          filterButton(context),
        ],
      ),
      body: _activated
          ? FilterScreen(
              quality: quality,
              minimumRating: minimumRating,
              genre: genre,
              sortBy: sortBy,
              orderBy: orderBy,
            )
          : HomeScreen(
              quality: widget.quality,
              minimumRating: widget.minimumRating,
              genre: widget.genre,
              sortBy: widget.sortBy == null ? "year" : widget.sortBy,
              orderBy: widget.orderBy),
      drawer: appDrawer(context),
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
      icon: Icon(
        _activated ? Icons.clear : Icons.filter_alt,
        size: 30.0,
      ),
      onPressed: () {
        if (_activated) {
          _activated = false;
        } else {
          _activated = true;
        }
        setState(() {});
      },
    );
  }
}
