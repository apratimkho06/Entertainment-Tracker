class MultiSearch {
  final int id;
  final String title;
  final String posterPath;
  final String mediaType;
  final String overview;
  final double voteAverage;

  MultiSearch(
      {this.id,
      this.title,
      this.posterPath,
      this.mediaType,
      this.overview,
      this.voteAverage});

  factory MultiSearch.fromJson(Map<String, dynamic> json) {
    return MultiSearch(
      id: json['id'] as int,
      title: json['media_type'] == 'movie'
          ? json['title'] as String
          : json['name'] as String,
      posterPath: json['poster_path'] as String,
      voteAverage: json['vote_average'] is int
          ? (json['vote_average'] as int).toDouble()
          : json['vote_average'],
      overview: json['overview'] as String,
      mediaType: json['media_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['media_type'] = this.mediaType;
    return data;
  }
}
