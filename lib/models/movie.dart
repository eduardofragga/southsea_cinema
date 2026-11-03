class Movie {
  final String id;
  final String title;
  final String ageRating;
  final String synopsis;
  final String screeningTime;
  final String runtime;
  final double ticketPrice;
  final String posterPath;

  const Movie({
    required this.id,
    required this.title,
    required this.ageRating,
    required this.synopsis,
    required this.screeningTime,
    required this.runtime,
    required this.ticketPrice,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      ageRating: json['ageRating'] as String,
      synopsis: json['synopsis'] as String,
      screeningTime: json['screeningTime'] as String,
      runtime: json['runtime'] as String,
      ticketPrice: (json['ticketPrice'] as num).toDouble(),
      posterPath: json['posterPath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'ageRating': ageRating,
      'synopsis': synopsis,
      'screeningTime': screeningTime,
      'runtime': runtime,
      'ticketPrice': ticketPrice,
      'posterPath': posterPath,
    };
  }

  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';
}
