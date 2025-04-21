import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

//* Configs
import 'package:cinemapedia/config/index.dart';

//* Entities
import '../../domain/movies.entity.dart';

class MoviesHorizontalListWidget extends StatefulWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final List<Movie> movies;
  final String title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const MoviesHorizontalListWidget({
    super.key,
    required this.movies,
    required this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MoviesHorizontalListWidget> createState() =>
      _MoviesHorizontalListWidgetState();

  //#endregion
}

class _MoviesHorizontalListWidgetState
    extends State<MoviesHorizontalListWidget> {
  //#region ----------------------------------- Variables ---------------------------------

  final horizontalScrollController = ScrollController();

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  @override
  void initState() {
    super.initState();
    horizontalScrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (horizontalScrollController.position.pixels + 200 >=
          horizontalScrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    horizontalScrollController.dispose();
    super.dispose();
  }

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          _Heading(title: widget.title, subtitle: widget.subtitle),
          Expanded(
            child: FadeInRight(
              child: ListView.builder(
                controller: horizontalScrollController,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: widget.movies.length,
                itemBuilder: (contex, index) {
                  final movie = widget.movies[index];
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: _Movie(movie: movie),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //#endregion
}

class _Heading extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final String title;
  final String? subtitle;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _Heading({required this.title, this.subtitle});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final texts = Theme.of(context).textTheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Text(title, style: texts.titleLarge),
            Spacer(),
            if (subtitle != null)
              FilledButton.tonal(
                onPressed: () {},
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                child: Text(subtitle!, style: texts.titleMedium),
              ),
          ],
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}

class _Movie extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Movie movie;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _Movie({required this.movie});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final texts = Theme.of(context).textTheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MovieImage(image: movie.posterPath),
          SizedBox(height: 5),
          Text(
            movie.title,
            style: texts.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          _MovieRate(
            rate: movie.voteAverage.toString(),
            popularity: movie.popularity,
          ),
        ],
      ),
    );

    //#endregion
  }

  //#endregion
}

class _MovieImage extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final String image;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _MovieImage({required this.image});

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image,
          width: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return progressIndicator(colors);
            }
            return FadeIn(child: child);
          },
        ),
      ),
    );
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
      width: 150,
      child: Row(
        spacing: 5,
        children: [
          Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
          Text(
            rate,
            style: texts.bodySmall?.copyWith(color: Colors.yellow.shade800),
          ),
          Spacer(),
          Text(
            NumbersPipe.formatNumber(popularity.toInt()),
            style: texts.bodySmall,
          ),
        ],
      ),
    );

    //#endregion
  }

  //#endregion
}
