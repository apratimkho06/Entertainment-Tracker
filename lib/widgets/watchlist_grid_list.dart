import 'package:entertainmenttracker/firestore/firestore_helper.dart';
import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/screens/movie_detail_sceen.dart';
import 'package:entertainmenttracker/screens/series_detail_screen.dart';
import 'package:flutter/material.dart';
import 'card_item.dart';

class WatchlistGridList extends StatefulWidget {
  final List<dynamic> objects;
  final ScrollController scrollController;
  final String getListFor;

  WatchlistGridList({this.objects, this.scrollController, this.getListFor});

  @override
  _WatchlistGridListState createState() => _WatchlistGridListState();
}

class _WatchlistGridListState extends State<WatchlistGridList> {
  @override
  Widget build(BuildContext context) {
    print('on deleting: ${widget.objects.length}');
    return widget.objects.length > 0
        ? GridView.builder(
            controller: widget.scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 0.85,
            ),
            itemCount: widget.objects.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () async {
                  _settingModalBottomSheet(context, widget.objects[index]);
                  print(6);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return widget.objects[index]['type'] == 'movies'
                          ? MovieDetailScreen(
                              movie: Movie.fromJson(widget.objects[index]),
                            )
                          : SeriesDetailScreen(
                              series: Series.fromJson(widget.objects[index]),
                            );
                    }),
                  );
                },
                child: CardItem(
                  title: widget.objects[index]['type'] == 'movies'
                      ? widget.objects[index]['title']
                      : widget.objects[index]['name'],
                  posterPath: widget.objects[index]['poster_path'],
                  showOption: false,
                ),
              );
            },
          )
        : Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Space looks empty. Start adding!!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Arvo',
                  ),
                ),
              ),
            ),
          );
  }

  void _settingModalBottomSheet(context, object) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    object['type'] == 'movies'
                        ? object['title']
                        : object['name'],
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text('Remove from ${widget.getListFor}'),
                    onTap: () async {
                      await FirestoreHelper.deleteShowFromFirestore(
                          object, widget.getListFor);
                      setState(() {
                        widget.objects.remove(object);
                      });
                      Navigator.pop(context);
                    }),
                widget.getListFor == 'watchlist'
                    ? ListTile(
                        leading: new Icon(Icons.add),
                        title: new Text('Add to watched'),
                        onTap: () async {
                          await FirestoreHelper.removeFromWatchlist(
                              object, context);
                          setState(() {
                            widget.objects.remove(object);
                          });
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
              ],
            ),
          );
        });
  }
}
