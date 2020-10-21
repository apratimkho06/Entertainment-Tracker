import 'dart:io';

import 'package:entertainmenttracker/firestore/firestore_helper.dart';
import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/screens/movie_detail_sceen.dart';
import 'package:flutter/material.dart';
import 'card_item.dart';

class MoviesGridList extends StatelessWidget {
  final List<Movie> movies;
  final ScrollController scrollController;

  MoviesGridList({this.movies, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        childAspectRatio: 0.85,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        Movie movie = movies[index];
        return GestureDetector(
          onTap: () {
            print('onClick: ${movie.title}');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return MovieDetailScreen(
                  movie: movie,
                );
              }),
            );
          },
          child: CardItem(
            title: movie.title,
            posterPath: movie.posterPath,
            showOption: true,
            addToWatched: () {
              FirestoreHelper.addMovieToFirestore(movie, 'watched', context);
            },
            addToWatchlist: () {
              FirestoreHelper.addMovieToFirestore(movie, 'watchlist', context);
            },
          ),
        );
      },
    );
  }
}
