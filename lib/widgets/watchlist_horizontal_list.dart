import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/screens/movie_detail_sceen.dart';
import 'package:entertainmenttracker/screens/series_detail_screen.dart';
import 'package:flutter/material.dart';

class WatchlistHorizontalList extends StatelessWidget {
  final String cardTitle;
  final Function onArrowPress;
  final List<dynamic> objects;

  WatchlistHorizontalList({this.cardTitle, this.onArrowPress, this.objects});

  @override
  Widget build(BuildContext context) {
    print('printing: ${objects.length}');
    return Visibility(
      visible: objects != null ? true : false,
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
                    cardTitle == 'watchlist' ? 'Watchlist' : 'Watched',
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
                    itemCount: objects.length < 10 ? objects.length : 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print('onClick: ${objects[index]['title']}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return objects[index]['type'] == 'movies'
                                  ? MovieDetailScreen(
                                      movie: Movie.fromJson(objects[index]),
                                    )
                                  : SeriesDetailScreen(
                                      series: Series.fromJson(objects[index]),
                                    );
                            }),
                          );
                        },
                        child: HorizontalCardItem(
                          posterPath: objects[index] == null
                              ? '/f496cm9enuEsZkSPzCwnTESEK5s.jpg'
                              : objects[index]['poster_path'],
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
