import 'package:flutter/material.dart';
import 'package:movie_finder/data/movie_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();
  final List<int> genreIds = [
    27,
    35,
    18,
    878,
    28,
  ]; // Horror, Comedy, Drama, Sci-Fi, Action
  Map<int, List<Map<String, dynamic>>> genreMovies = {};
  Map<int, String> genreMap = {};

  @override
  void initState() {
    super.initState();
    _loadGenresAndMovies();
  }

  Future<void> _loadGenresAndMovies() async {
    genreMap = await _movieService.fetchGenreMap();
    for (int id in genreIds) {
      final movies = await _movieService.fetchMoviesByGenre(id);
      setState(() {
        genreMovies[id] = movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Popular Movies by Genre")),
      body:
          genreMovies.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children:
                      genreIds.map((id) {
                        final genreName = genreMap[id] ?? 'Genre';
                        final movies = genreMovies[id] ?? [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                genreName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                  return Container(
                                    width: 250,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                                          height: 100,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                movie['title'] ?? 'No title',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Release: ${movie['release_date']?.split('-').first ?? 'Unknown'}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
    );
  }
}
