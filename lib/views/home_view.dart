import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

class HomeView extends StatelessWidget {
  final BasketRepository basketRepository;

  const HomeView({
    super.key,
    required this.basketRepository,
  });

  @override
  Widget build(BuildContext context) {
    final movies = MovieRepository().getMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return MovieCard(
            movie: movie,
            onBookPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieListing(
                    movie: movie,
                    basketRepository: basketRepository,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
