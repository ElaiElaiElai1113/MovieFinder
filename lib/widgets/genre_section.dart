import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_card.dart';

class GenreSection extends StatelessWidget {
  final String genre;
  final List<Movie> movies;

  const GenreSection({super.key, required this.genre, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            genre,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: movies.map((movie) => MovieCard(movie: movie)).toList(),
          ),
        ),
      ],
    );
  }
}
