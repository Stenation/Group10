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
