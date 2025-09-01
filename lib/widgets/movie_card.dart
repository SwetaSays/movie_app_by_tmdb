import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../core/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final VoidCallback onBookmark;

  const MovieCard(
      {super.key,
      required this.movie,
      required this.onTap,
      required this.onBookmark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            movie.posterPath != null
                ? Image.network(
                    '${IMAGE_BASE_URL}${movie.posterPath}',
                    height: 180,
                    fit: BoxFit.cover,
                  )
                : Container(height: 180, color: Colors.grey),
            const SizedBox(height: 5),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            IconButton(
                icon: Icon(
                  movie.isBookmarked == 1
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: Colors.red,
                ),
                onPressed: onBookmark)
          ],
        ),
      ),
    );
  }
}
