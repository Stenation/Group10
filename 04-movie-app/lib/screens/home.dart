import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../movie.dart';
import '../db/database_helper.dart';
import 'details.dart';

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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadAndShow();
    _searchController.addListener(() {
      final q = _searchController.text;
      if (q != _searchQuery) {
        _performSearch(q);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadAndShow() async {
    setState(() => _isLoading = true);

    final movies = await _loadMovies();
    _movies = movies;

    setState(() => _isLoading = false);
  }

  Future<List<Movie>> _loadMovies() async {
    final dbMovies = await DatabaseHelper.instance.getAllMovies();
    if (dbMovies.isNotEmpty) {
      print('db is not empty, movie data loaded from db');
      print('Loaded ${dbMovies.length} movies from database.');
      return dbMovies;
    }

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

  Future<void> _performSearch(String q) async {
    _searchQuery = q;
    // Query the local database for matching titles (empty query returns all)
    final results = await DatabaseHelper.instance.searchMovies(q);
    setState(() {
      _movies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // increase height to fit search field below title
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                onChanged: (v) => _performSearch(v),
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  hintText: 'Search movies by title',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.black54),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
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
