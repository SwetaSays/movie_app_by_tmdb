import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_page.dart';

class BookmarkedPage extends StatelessWidget {
  const BookmarkedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Movies')),
      body: FutureBuilder(
          future: viewModel.repository.getBookmarkedMovies(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  movie: movie,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MovieDetailPage(movie: movie)));
                  },
                  onBookmark: () => viewModel.bookmarkMovie(movie),
                );
              },
            );
          }),
    );
  }
}
