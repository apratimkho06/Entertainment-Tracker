import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/screens/movie_detail_sceen.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalList extends StatelessWidget {
  final String cardTitle;
  final Function onArrowPress;
  final List<Movie> movies;

  MoviesHorizontalList({this.cardTitle, this.onArrowPress, this.movies});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: movies != null ? true : false,
      child: Container(
        color: Colors.transparent,
        height: 250,
        child: Column(
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
                      fontFamily: 'Arvo',
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
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print('onClick: ${movies[index].title}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return MovieDetailScreen(
                                movie: movies[index],
                              );
                            }),
                          );
                        },
                        child: HorizontalCardItem(
                          posterPath: movies[index] == null
                              ? '/f496cm9enuEsZkSPzCwnTESEK5s.jpg'
                              : movies[index].posterPath,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalCardItem extends StatelessWidget {
  final String posterPath;

  HorizontalCardItem({this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('http://image.tmdb.org/t/p/w185$posterPath'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
