import 'package:entertainmenttracker/model/series.dart';

class SeriesResults {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Series> results;

  SeriesResults({this.page, this.totalResults, this.totalPages, this.results});

  factory SeriesResults.fromJson(Map<String, dynamic> json) {
    List<Series> resultsList = new List<Series>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        resultsList.add(new Series.fromJson(v));
      });
    }
    return SeriesResults(
      page: json['id'] as int,
      totalResults: json['title'] as int,
      totalPages: json['poster_path'] as int,
      results: resultsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (data['results'] != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
