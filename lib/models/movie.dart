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

  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';
}
