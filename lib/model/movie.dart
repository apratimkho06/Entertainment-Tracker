import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entertainmenttracker/firestore/firestore_helper.dart';

class Movie {
  final int id;
  final String posterPath;
  final String title;
  final double voteAverage;
  final String overview;
  final String type;
//  final Timestamp timeStamp;

  Movie({
    this.id,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.overview,
    this.type = 'movies',
//    this.timeStamp,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
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
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    return data;
  }
}
