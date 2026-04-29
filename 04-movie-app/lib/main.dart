import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'movie.dart';
import 'db/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(
        title: 'Movies',
        movieUri:
            'https://git.fiw.fhws.de/introduction-to-flutter-2025ss/unit-07-http-and-bloc/-/raw/329759b27023c59828215b51dd081b58c5c07d50/http_demo/movie_data.json',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.movieUri});

  final String title;
  final String movieUri;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _movies = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAndShow();
  }

  void _loadAndShow() async {
    setState(() => _isLoading = true);

    final movies = await _loadMovies();
    _movies = movies;

    setState(() => _isLoading = false);
  }

  Future<List<Movie>> _loadMovies() async {
    // First try to load movies from the local database
    final dbMovies = await DatabaseHelper.instance.getAllMovies();
    if (dbMovies.isNotEmpty) {
      print('db is not empty, movie data loaded from db');
      print('Loaded ${dbMovies.length} movies from database.');
      return dbMovies;
    }

    // If the database is empty, load from API and save into the database
    try {
      final response = await http.get(Uri.parse(widget.movieUri));

      if (response.statusCode == 200) {
        final moviesJson = jsonDecode(response.body) as List;
        final movies = List.generate(
          moviesJson.length,
          (index) => Movie.fromJson(moviesJson[index]),
        );

        if (movies.isNotEmpty) {
          await DatabaseHelper.instance.insertMovies(movies);
          print('movie data downloaded from API and saved to db');
          print('Saved ${movies.length} movies into database.');
        }

        return movies;
      } else {
        print('failed to load data from API');
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('failed to load data from API');
      print('Exception: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.director ?? 'No director info'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

// ======================= DETAIL SCREEN =======================

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
            // Poster
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

            // Basic Info
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

            // Plot
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
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(movie.plot!),
                    ],
                  ),
                ),
              ),

            // Awards
            if (movie.awards != null &&
                movie.awards!.isNotEmpty &&
                movie.awards != "N/A")
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text('🏆 Awards: ${movie.awards}'),
              ),

            // Additional Images
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