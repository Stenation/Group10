import 'package:flutter/material.dart';

import '../movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.poster != null &&
                movie.poster!.isNotEmpty &&
                movie.poster != "N/A")
              Center(
                child: Image.network(
                  movie.poster!,
                  height: 300,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 150),
                ),
              ),
            const SizedBox(height: 16),

            if (movie.year != null && movie.year!.isNotEmpty)
              _buildInfoRow('Year', movie.year!),
            if (movie.runtime != null && movie.runtime!.isNotEmpty)
              _buildInfoRow('Runtime', movie.runtime!),
            if (movie.genre != null && movie.genre!.isNotEmpty)
              _buildInfoRow('Genre', movie.genre!),
            if (movie.director != null && movie.director!.isNotEmpty)
              _buildInfoRow('Director', movie.director!),
            if (movie.actors != null && movie.actors!.isNotEmpty)
              _buildInfoRow('Cast', movie.actors!),
            if (movie.language != null && movie.language!.isNotEmpty)
              _buildInfoRow('Language', movie.language!),
            if (movie.country != null && movie.country!.isNotEmpty)
              _buildInfoRow('Country', movie.country!),
            if (movie.imdbRating != null && movie.imdbRating != "N/A")
              _buildInfoRow('IMDb Rating', movie.imdbRating!),
            if (movie.type != null) _buildInfoRow('Type', movie.type!),
            if (movie.totalSeasons != null)
              _buildInfoRow('Seasons', movie.totalSeasons!.toString()),
            if (movie.comingSoon == true)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Chip(
                  label: Text('Coming Soon'),
                  backgroundColor: Colors.orange,
                ),
              ),

            const SizedBox(height: 12),

            if (movie.plot != null && movie.plot!.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Plot',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(movie.plot!),
                    ],
                  ),
                ),
              ),

            if (movie.awards != null &&
                movie.awards!.isNotEmpty &&
                movie.awards != "N/A")
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text('🏆 Awards: ${movie.awards}'),
              ),

            if (movie.images != null && movie.images!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Additional Images',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.images!.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, idx) {
                    final imgUrl = movie.images![idx];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imgUrl,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.broken_image, size: 60),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
