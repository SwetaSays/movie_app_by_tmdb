import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_page.dart';
import 'bookmarked_page.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              iconSize: 28,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchPage()));
              }),
          IconButton(
              icon: const Icon(Icons.bookmark),
              iconSize: 28,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BookmarkedPage()));
              })
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Trending Movies',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.trendingMovies.length,
                      itemBuilder: (context, index) {
                        final movie = viewModel.trendingMovies[index];
                        return MovieCard(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MovieDetailPage(movie: movie)),
                            );
                          },
                          onBookmark: () => viewModel.bookmarkMovie(movie),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Now Playing Movies',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.nowPlayingMovies.length,
                      itemBuilder: (context, index) {
                        final movie = viewModel.nowPlayingMovies[index];
                        return MovieCard(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MovieDetailPage(movie: movie)),
                            );
                          },
                          onBookmark: () => viewModel.bookmarkMovie(movie),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
