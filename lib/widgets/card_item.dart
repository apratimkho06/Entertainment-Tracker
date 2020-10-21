import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String posterPath;
  final String title;
  final Function addToWatchlist;
  final Function addToWatched;
  final bool showOption;

  CardItem({
    this.title,
    this.posterPath,
    this.addToWatchlist,
    this.addToWatched,
    this.showOption,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: posterPath != null
                ? NetworkImage('http://image.tmdb.org/t/p/w185$posterPath')
                : AssetImage('assets/default_poster.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              visible: showOption,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            child: new SimpleDialog(
                              title: new Text('Select Assignment'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  child: Text('Add to Watched'),
                                  onPressed: () {
                                    addToWatched();
                                    Navigator.pop(context);
                                  },
                                ),
                                SimpleDialogOption(
                                  child: Text('Add to Watchlist'),
                                  onPressed: () {
                                    addToWatchlist();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ));
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            posterPath == null
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          backgroundColor: Colors.black54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
