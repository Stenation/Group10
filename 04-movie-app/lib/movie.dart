class Movie {
  final String title;
  final String? year;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? plot;
  final String? language;
  final String? country;
  final String? awards;
  final String? poster;
  final String? metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? imdbID;
  final String? type;
  final List<String>? images;
  final int? totalSeasons;
  final bool? comingSoon;

  Movie({
    required this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbID,
    this.type,
    this.images,
    this.totalSeasons,
    this.comingSoon,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Helper to convert http -> https
    String? toHttps(String? url) {
      if (url == null || url.isEmpty) return url;
      return url.replaceFirst('http://', 'https://');
    }

    return Movie(
      title: json['Title'] as String,
      year: json['Year'] as String?,
      rated: json['Rated'] as String?,
      released: json['Released'] as String?,
      runtime: json['Runtime'] as String?,
      genre: json['Genre'] as String?,
      director: json['Director'] as String?,
      writer: json['Writer'] as String?,
      actors: json['Actors'] as String?,
      plot: json['Plot'] as String?,
      language: json['Language'] as String?,
      country: json['Country'] as String?,
      awards: json['Awards'] as String?,
      poster: toHttps(json['Poster'] as String?),
      metascore: json['Metascore'] as String?,
      imdbRating: json['imdbRating'] as String?,
      imdbVotes: json['imdbVotes'] as String?,
      imdbID: json['imdbID'] as String?,
      type: json['Type'] as String?,
      images: (json['Images'] as List?)?.map((e) => e.toString()).toList(),
      totalSeasons: json['totalSeasons'] != null
          ? int.tryParse(json['totalSeasons'].toString())
          : null,
      comingSoon: json['ComingSoon'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Year': year,
        'Rated': rated,
        'Released': released,
        'Runtime': runtime,
        'Genre': genre,
        'Director': director,
        'Writer': writer,
        'Actors': actors,
        'Plot': plot,
        'Language': language,
        'Country': country,
        'Awards': awards,
        'Poster': poster,
        'Metascore': metascore,
        'imdbRating': imdbRating,
        'imdbVotes': imdbVotes,
        'imdbID': imdbID,
        'Type': type,
        'Images': images,
        'totalSeasons': totalSeasons,
        'ComingSoon': comingSoon,
      };
}