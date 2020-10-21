import 'package:entertainmenttracker/model/multi_search.dart';

class MultiSearchResults {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<MultiSearch> results;

  MultiSearchResults(
      {this.page, this.totalResults, this.totalPages, this.results});

  factory MultiSearchResults.fromJson(Map<String, dynamic> json) {
    List<MultiSearch> resultsList = new List<MultiSearch>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        resultsList.add(new MultiSearch.fromJson(v));
      });
    }
    return MultiSearchResults(
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
