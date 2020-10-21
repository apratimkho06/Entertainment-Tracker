import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/screens/series_detail_screen.dart';
import 'package:flutter/material.dart';

class SeriesHorizontalList extends StatelessWidget {
  final String cardTitle;
  final Function onArrowPress;
  final List<Series> series;

  SeriesHorizontalList({this.cardTitle, this.onArrowPress, this.series});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        print('onClick: ${series[index].name}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SeriesDetailScreen(
                              series: series[index],
                            );
                          }),
                        );
                      },
                      child: HorizontalCardItem(
                        posterPath: series == null
                            ? '/f496cm9enuEsZkSPzCwnTESEK5s.jpg'
                            : series[index].posterPath,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
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
