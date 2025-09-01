  import '../core/api_client.dart';
import '../core/database_helper.dart';
import '../models/movie.dart';
import '../core/constants.dart';

class MovieRepository {
  final ApiClient apiClient;
  final DatabaseHelper dbHelper = DatabaseHelper();

  MovieRepository(this.apiClient);

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await apiClient.getTrending(TMDB_API_KEY);
      for (var movie in response.results) {
        await dbHelper.insertMovie(movie);
      }
      return response.results;
    } catch (_) {
      return await dbHelper.getBookmarkedMovies();
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final response = await apiClient.getNowPlaying(TMDB_API_KEY);
      for (var movie in response.results) {
        await dbHelper.insertMovie(movie);
      }
      return response.results;
    } catch (_) {
      return await dbHelper.getBookmarkedMovies();
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await apiClient.searchMovies(TMDB_API_KEY, query);
    return response.results;
  }

  Future<void> bookmarkMovie(Movie movie) async {
    movie.isBookmarked = 1;
    await dbHelper.updateMovie(movie);
  }

  Future<List<Movie>> getBookmarkedMovies() async {
    return await dbHelper.getBookmarkedMovies();
  }
}
