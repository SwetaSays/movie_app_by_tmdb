import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/movie_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("trending/movie/week")
  Future<MovieResponse> getTrending(@Query("api_key") String apiKey);

  @GET("movie/now_playing")
  Future<MovieResponse> getNowPlaying(@Query("api_key") String apiKey);

  @GET("search/movie")
  Future<MovieResponse> searchMovies(
      @Query("api_key") String apiKey, @Query("query") String query);
}
