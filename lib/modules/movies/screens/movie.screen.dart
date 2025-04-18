import 'package:cinemapedia/config/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Entities
import '../domain/movies.entity.dart';

//* Providers
import '../providers/movie_details.providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  //#region ----------------------------------- Variables ---------------------------------

  static const String routeName = 'movie_screen';
  final String id;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const MovieScreen({super.key, required this.id});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  _MovieScreenState createState() => _MovieScreenState();

  //#endregion
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  //#region ----------------------------------- Variables ---------------------------------
  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  @override
  void initState() {
    super.initState();
    ref.read(movieDetailsProvider.notifier).getMovieById(widget.id);
  }

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    Movie? movie = ref.watch(movieDetailsProvider)[widget.id];

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Scaffold(
      body:
          movie == null
              ? Center(child: CircularProgressIndicator())
              : CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [_AppBar(movie: movie), _MovieDetails(movie: movie)],
              ),
    );

    //#endregion
  }

  //#endregion
}

class _AppBar extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Movie movie;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _AppBar({required this.movie});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final size = MediaQuery.of(context).size;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SliverAppBar(
      expandedHeight: size.height * 0.7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(movie.posterPath, fit: BoxFit.cover),
            ),
            _MovieBackground(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87],
              stops: [0.8, 1.0],
            ),
            _MovieBackground(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black45, Colors.transparent],
              stops: [0.0, 0.3],
            ),
          ],
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}

class _MovieBackground extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Alignment begin;
  final Alignment end;
  final List<double> stops;
  final List<Color> colors;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _MovieBackground({
    required this.stops,
    required this.begin,
    required this.end,
    required this.colors,
  });

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: colors,
            stops: stops,
          ),
        ),
      ),
    );
  }

  //#endregion
}

class _MovieDetails extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Movie movie;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _MovieDetails({required this.movie});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final texts = Theme.of(context).textTheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            spacing: 10,
            children: [
              Text(movie.overview, style: texts.bodyLarge),
              _MovieRate(
                rate: movie.voteAverage.toString(),
                popularity: movie.popularity,
              ),
              _MovieGenres(genres: movie.genreIds),
            ],
          ),
        );
      }, childCount: 1),
    );

    //#endregion
  }

  //#endregion
}

class _MovieRate extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final String rate;
  final double popularity;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _MovieRate({required this.rate, required this.popularity});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final texts = Theme.of(context).textTheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------
    return SizedBox(
      width: double.infinity,
      child: Row(
        spacing: 5,
        children: [
          Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
          Text(
            rate,
            style: texts.bodyLarge?.copyWith(color: Colors.yellow.shade800),
          ),
          Spacer(),
          Text(
            NumbersPipe.formatNumber(popularity.toInt()),
            style: texts.bodyLarge,
          ),
        ],
      ),
    );

    //#endregion
  }

  //#endregion
}

class _MovieGenres extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final List<String> genres;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _MovieGenres({required this.genres});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: [
          ...genres.map((e) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: Chip(label: Text(e)),
            );
          }),
        ],
      ),
    );
  }

  //#endregion
}
