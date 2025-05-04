import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

//* Config
import 'package:cinemapedia/config/index.dart';

//* Entities
import '../../domain/entities/movie.dart';
import 'package:cinemapedia/modules/actors/domain/index.dart';

//* Providers
import '../../infrastructure/providers/movie_details.provider.dart';
import 'package:cinemapedia/modules/actors/infrastructure/index.dart';
import 'package:cinemapedia/modules/favorites/infrastructure/index.dart';

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
    ref.read(actorsProvider.notifier).getActorsByMovieId(widget.id);
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
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [_AppBar(movie: movie), _MovieDetails(movie: movie)],
              ),
    );

    //#endregion
  }

  //#endregion
}

class _AppBar extends ConsumerWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Movie movie;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _AppBar({required this.movie});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //#region ----------------------------------- Variables ---------------------------------

    final size = MediaQuery.of(context).size;
    final isFavorite = ref.watch(isFavoriteProvider(movie.id));

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SliverAppBar(
      expandedHeight: size.height * 0.7,
      collapsedHeight: size.height * 0.2,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoritesMoviesProvider.notifier)
                .toggleMovie(movie: movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavorite.when(
            data: (value) {
              return value
                  ? const Icon(Icons.favorite_rounded, color: Colors.red)
                  : const Icon(Icons.favorite_border_rounded);
            },
            loading: () => const Icon(Icons.favorite_border_rounded),
            error: (_, __) => const Icon(Icons.favorite_border_rounded),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _MovieBackground(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54],
              stops: [0.8, 1.0],
            ),
            const _MovieBackground(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black45, Colors.transparent],
              stops: [0.0, 0.3],
            ),
            const _MovieBackground(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            spacing: 10,
            children: [
              Text(movie.overview, style: texts.bodyLarge),
              _MovieRate(
                rate: movie.voteAverage.toString(),
                popularity: movie.popularity,
              ),
              _MovieGenres(genres: movie.genreIds),
              _MovieActors(movieId: movie.id.toString()),
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
          const Spacer(),
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
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Chip(label: Text(e)),
            );
          }),
        ],
      ),
    );
  }

  //#endregion
}

class _MovieActors extends ConsumerWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final String movieId;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _MovieActors({required this.movieId});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //#region ----------------------------------- Variables ---------------------------------

    final actors = ref.watch(actorsProvider);

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SizedBox(
      height: 350,
      child:
          actors[movieId] == null
              ? const Center(child: CircularProgressIndicator())
              : FadeInRight(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: actors[movieId]!.length,
                  itemBuilder: (contex, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: _MovieActor(actor: actors[movieId]![index]),
                    );
                  },
                ),
              ),
    );

    //#endregion
  }

  //#endregion
}

class _MovieActor extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Actor actor;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _MovieActor({required this.actor});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final texts = Theme.of(context).textTheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ActorImage(image: actor.profilePath),
          const SizedBox(height: 3),
          Text(
            actor.name,
            style: texts.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            actor.character ?? '',
            style: texts.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    //#endregion
  }

  //#endregion
}

class _ActorImage extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final String image;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _ActorImage({required this.image});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Widget progressIndicator(ColorScheme colors) {
    return SizedBox(
      height: 200,
      width: 150,
      child: Center(child: CircularProgressIndicator(color: colors.primary)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final colors = Theme.of(context).colorScheme;

    //#endregion

    //#region ----------------------------------- Return ---------------------------------

    return SizedBox(
      width: 150,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return progressIndicator(colors);
            }
            return FadeIn(child: child);
          },
          errorBuilder: (context, error, stackTrace) {
            return FadeIn(child: const Placeholder());
          },
        ),
      ),
    );
  }

  //#endregion
}
