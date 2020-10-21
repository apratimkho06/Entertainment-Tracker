import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/networking/networking.dart';
import 'package:entertainmenttracker/screens/series_screen.dart';
import 'package:entertainmenttracker/widgets/series_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class SeriesHorizontalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Series>>(
      future: NetworkHelper.fetchSeries(http.Client(), 'popular'),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? SeriesHorizontalList(
                cardTitle: 'Series',
                series: snapshot.data,
                onArrowPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return SeriesScreen();
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
