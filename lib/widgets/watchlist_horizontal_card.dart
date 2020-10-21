import 'package:entertainmenttracker/firestore/firestore_helper.dart';
import 'package:entertainmenttracker/screens/watchlist_screen.dart';
import 'package:entertainmenttracker/widgets/watchlist_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WatchlistHorizontalCard extends StatelessWidget {
  final String getListFor;

  WatchlistHorizontalCard({this.getListFor});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: FirestoreHelper.getWatchlistOrWatched(getListFor, true),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Visibility(
                visible: snapshot.data.length == 0 ? false : true,
                child: WatchlistHorizontalList(
                  cardTitle: getListFor,
                  objects: snapshot.data,
                  onArrowPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return WatchlistScreen(
                          getListFor: getListFor,
                        );
                      }),
                    );
                  },
                ),
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
