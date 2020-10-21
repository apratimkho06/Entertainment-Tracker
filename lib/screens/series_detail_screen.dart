import 'package:entertainmenttracker/firestore/firestore_helper.dart';
import 'package:entertainmenttracker/model/series.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SeriesDetailScreen extends StatelessWidget {
  final Series series;

  SeriesDetailScreen({this.series});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              'http://image.tmdb.org/t/p/w500${series.posterPath}',
              fit: BoxFit.fitHeight,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Container(width: 400.0, height: 400.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://image.tmdb.org/t/p/w500${series.posterPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              series.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: 'Arvo',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '${series.voteAverage}/10',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Arvo',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      series.overview,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Arvo',
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AddButton(
                          series: series,
                          filter: 'watchlist',
                        ),
                        AddButton(
                          series: series,
                          filter: 'watched',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final Series series;
  final String filter;
  final Function onPressed;

  AddButton({this.series, this.filter, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 50.0,
      child: RaisedButton(
        child: Text(
          filter == 'watchlist' ? 'Watchlist' : 'Watched',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Arvo',
            fontSize: 20.0,
          ),
        ),
        color: Color(0xaa3C3261),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          FirestoreHelper.addSeriesToFirestore(series, filter, context);
        },
      ),
    );
  }
}
