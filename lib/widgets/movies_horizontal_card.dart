import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/networking/networking.dart';
import 'package:entertainmenttracker/screens/movie_screen.dart';
import 'package:entertainmenttracker/widgets/movies_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class MoviesHorizontalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
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
    );
  }
}
