import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/networking/networking.dart';
import 'package:entertainmenttracker/screens/movie_screen.dart';
import 'package:entertainmenttracker/widgets/movies_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ReusableCard extends StatelessWidget {
  final String cardTitle;
  final Function onArrowPress;

  ReusableCard({this.cardTitle, this.onArrowPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  cardTitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: onArrowPress,
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future: NetworkHelper.fetchMovies(http.Client(), 'popular'),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? MoviesHorizontalList(
                        cardTitle: 'Movies',
                        movies: snapshot.data,
                        onArrowPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return MovieScreen();
                            }),
                          );
                        },
                      )
                    : Center(
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 25.0,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
