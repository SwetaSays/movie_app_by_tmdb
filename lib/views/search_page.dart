import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/search_viewmodel.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Search Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Search Movies', border: OutlineInputBorder()),
              onChanged: viewModel.search,
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: viewModel.searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = viewModel.searchResults[index];
                      return MovieCard(
                        movie: movie,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MovieDetailPage(movie: movie)));
                        },
                        onBookmark: () => viewModel.bookmarkMovie(movie),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
