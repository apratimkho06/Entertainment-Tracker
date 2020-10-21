import 'movie.dart';

class MovieResults {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;

  MovieResults({this.page, this.totalResults, this.totalPages, this.results});

  factory MovieResults.fromJson(Map<String, dynamic> json) {
    List<Movie> resultsList = new List<Movie>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        resultsList.add(new Movie.fromJson(v));
      });
    }
    return MovieResults(
      page: json['page'] as int,
      totalResults: json['total_results'] as int,
      totalPages: json['total_pages'] as int,
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
