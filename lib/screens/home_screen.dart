import 'package:entertainmenttracker/firestore/firestore_helper.dart';
import 'package:entertainmenttracker/screens/search_list_screen.dart';
import 'package:entertainmenttracker/widgets/movies_horizontal_card.dart';
import 'package:entertainmenttracker/widgets/series_horizontal_card.dart';
import 'package:entertainmenttracker/widgets/watchlist_horizontal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    //FirestoreHelper.deleteAllDocuments();
    //FirestoreHelper.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Netstar'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchListScreen()));
              }),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                WatchlistHorizontalCard(
                  getListFor: 'watchlist',
                ),
                SizedBox(height: 10.0),
                WatchlistHorizontalCard(
                  getListFor: 'watched',
                ),
                SizedBox(height: 10.0),
                MoviesHorizontalCard(),
                SizedBox(height: 10.0),
                SeriesHorizontalCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
