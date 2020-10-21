import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/model/multi_search.dart';
import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/networking/networking.dart';
import 'package:entertainmenttracker/screens/movie_detail_sceen.dart';
import 'package:entertainmenttracker/screens/series_detail_screen.dart';
import 'package:entertainmenttracker/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class SearchListScreen extends StatefulWidget {
  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  final FocusNode focusNode = new FocusNode();

  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<MultiSearch> _results = List();

  Timer debounceTimer;

  _SearchListScreenState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });

    final queries = await NetworkHelper.fetchQuery(http.Client(), query);
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (queries != null) {
          _results = queries;
        } else {
          _error = 'Error searching query';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchQuery,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(end: 16.0),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return Center(
        child: SpinKitFadingFour(
          color: Colors.white,
        ),
      );
    } else if (_error != null) {
      return Center(
        child: Text(_error),
      );
    } else if (_searchQuery.text.isEmpty) {
      return Center(
        child: Text('Begin search by typing on search bar'),
      );
    } else {
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 0.85,
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print(_results[index].mediaType);
                if (_results[index].mediaType == 'tv') {
                  Series series = Series(
                    id: _results[index].id,
                    posterPath: _results[index].posterPath,
                    name: _results[index].title,
                    voteAverage: _results[index].voteAverage,
                    overview: _results[index].overview,
                    type: 'series',
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeriesDetailScreen(
                        series: series,
                      ),
                    ),
                  );
                } else {
                  Movie movie = Movie(
                    id: _results[index].id,
                    posterPath: _results[index].posterPath,
                    title: _results[index].title,
                    voteAverage: _results[index].voteAverage,
                    overview: _results[index].overview,
                    type: 'movies',
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        movie: movie,
                      ),
                    ),
                  );
                }
              },
              child: CardItem(
                title: _results[index].title,
                posterPath: _results[index].posterPath,
                showOption: false,
              ),
            );
          });
    }
  }
}
