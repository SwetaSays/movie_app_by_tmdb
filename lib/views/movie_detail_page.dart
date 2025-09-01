import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

  void shareMovie(BuildContext context) async {
    final url = "myapp://movie/${movie.id}";
    await launchUrl(Uri.parse(url));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Shared link copied!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => shareMovie(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            movie.posterPath != null
                ? Image.network('${IMAGE_BASE_URL}${movie.posterPath}')
                : const SizedBox(),
            const SizedBox(height: 20),
            Text(movie.overview ?? "No overview available"),
          ],
        ),
      ),
    );
  }
}
