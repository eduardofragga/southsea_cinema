import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onBookPressed;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                movie.posterPath,
                width: double.infinity,
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 220,
                    child: Center(
                      child: Icon(
                        Icons.movie,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  movie.ageRating,
                  style: const TextStyle(
                    color: cinemaBrand,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              movie.synopsis,
              style: const TextStyle(
                color: cinemaFontWhite,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: cinemaBrand,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  movie.screeningTime,
                  style: const TextStyle(
                    color: cinemaFontWhite,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  movie.runtime,
                  style: const TextStyle(
                    color: cinemaFontWhite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Ticket price: £${movie.ticketPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                color: cinemaFontWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onBookPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: cinemaBrand,
                  foregroundColor: cinemaFontWhite,
                ),
                child: const Text('Book Tickets'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
