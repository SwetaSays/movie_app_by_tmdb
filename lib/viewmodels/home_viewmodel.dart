import 'package:flutter/material.dart';
import '../repository/movie_repository.dart';
import '../core/api_client.dart';
import 'package:dio/dio.dart';
import '../models/movie.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieRepository repository = MovieRepository(ApiClient(Dio()));

  List<Movie> trendingMovies = [];
  List<Movie> nowPlayingMovies = [];
  bool isLoading = true;

  HomeViewModel() {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    isLoading = true;
    notifyListeners();
    trendingMovies = await repository.getTrendingMovies();
    nowPlayingMovies = await repository.getNowPlayingMovies();
    isLoading = false;
    notifyListeners();
  }

  Future<void> bookmarkMovie(Movie movie) async {
    await repository.bookmarkMovie(movie);
    notifyListeners();
  }
}
