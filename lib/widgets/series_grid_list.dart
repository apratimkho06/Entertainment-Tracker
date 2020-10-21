import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entertainmenttracker/firestore/firestore_helper.dart';
import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/screens/series_detail_screen.dart';
import 'package:flutter/material.dart';
import 'card_item.dart';

class SeriesGridList extends StatelessWidget {
  final List<Series> series;
  final ScrollController scrollController;

  SeriesGridList({this.series, this.scrollController});

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
      itemCount: series.length,
      itemBuilder: (context, index) {
        Series serie = series[index];
        return GestureDetector(
          onTap: () {
            print('onClick: ${serie.name}');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return SeriesDetailScreen(
                  series: serie,
                );
              }),
            );
          },
          child: CardItem(
            title: serie.name,
            posterPath: serie.posterPath,
            showOption: true,
            addToWatched: () {
              FirestoreHelper.addSeriesToFirestore(serie, 'watched', context);
            },
            addToWatchlist: () {
              FirestoreHelper.addSeriesToFirestore(serie, 'watchlist', context);
            },
          ),
        );
      },
    );
  }
}
