import 'dart:async';
import 'package:flutter/material.dart';
import '../repository/movie_repository.dart';
import '../core/api_client.dart';
import 'package:dio/dio.dart';
import '../models/movie.dart';

class SearchViewModel extends ChangeNotifier {
  final MovieRepository repository = MovieRepository(ApiClient(Dio()));

  List<Movie> searchResults = [];
  bool isLoading = false;
  Timer? _debounce;

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) return;
      isLoading = true;
      notifyListeners();
      searchResults = await repository.searchMovies(query);
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> bookmarkMovie(Movie movie) async {
    await repository.bookmarkMovie(movie);
    notifyListeners();
  }
}
