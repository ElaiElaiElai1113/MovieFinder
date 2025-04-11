import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String _apiKey = 'dd2f61e3358da7dad370d167cb47c841';

  Future<List<Map<String, dynamic>>> fetchMoviesByGenre(int genreId) async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&with_genres=$genreId';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<Map<int, String>> fetchGenreMap() async {
    final url =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    final genres = Map<int, String>.fromIterable(
      data['genres'],
      key: (e) => e['id'],
      value: (e) => e['name'],
    );

    return genres;
  }
}
