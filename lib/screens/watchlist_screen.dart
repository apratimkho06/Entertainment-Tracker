import 'package:entertainmenttracker/firestore/firestore_helper.dart';
import 'package:entertainmenttracker/widgets/watchlist_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WatchlistScreen extends StatefulWidget {
  final String getListFor;

  WatchlistScreen({this.getListFor});

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.getListFor == 'watchlist'
            ? Text('Watchlist')
            : Text('Watched'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<dynamic>>(
                future: FirestoreHelper.getWatchlistOrWatched(
                    widget.getListFor, false),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? WatchlistGridList(
                          objects: snapshot.data,
                          scrollController: _scrollController,
                          getListFor: widget.getListFor,
                        )
                      : Center(
                          child: SpinKitDoubleBounce(
                            color: Colors.white,
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
