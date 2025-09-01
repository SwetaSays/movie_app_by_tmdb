import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../core/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final VoidCallback onBookmark;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster with bookmark button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: movie.posterPath != null
                      ? Image.network(
                          '$IMAGE_BASE_URL${movie.posterPath}',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey,
                          child: const Icon(Icons.image, size: 50, color: Colors.white),
                        ),
                ),

                // Bookmark floating
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: onBookmark,
                    child: Icon(
                      movie.isBookmarked == 1
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: Colors.deepOrange,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            // Movie title 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
