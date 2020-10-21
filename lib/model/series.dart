import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entertainmenttracker/firestore/firestore_helper.dart';

class Series {
  final int id;
  final String posterPath;
  final String name;
  final double voteAverage;
  final String overview;
  final String type;
//  final Timestamp timeStamp;

  Series({
    this.id,
    this.posterPath,
    this.name,
    this.voteAverage,
    this.overview,
    this.type = 'series',
//    this.timeStamp,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'] as int,
      name: json['name'] as String,
      posterPath: json['poster_path'] as String,
      voteAverage: json['vote_average'] is int
          ? (json['vote_average'] as int).toDouble()
          : json['vote_average'],
      overview: json['overview'] as String,
//      timeStamp: Timestamp.fromMillisecondsSinceEpoch(
//          DateTime.now().millisecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['poster_path'] = this.posterPath;
    data['name'] = this.name;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    return data;
  }
}
