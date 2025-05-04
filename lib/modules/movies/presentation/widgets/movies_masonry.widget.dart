import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//* Entities
import '../../domain/entities/movie.dart';

class MoviesMasonryWidget extends StatefulWidget {
  //#region --------------------------------- Variables ---------------------------------

  final List<Movie> movies;
  final VoidCallback loadNextPage;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const MoviesMasonryWidget({
    super.key,
    required this.movies,
    required this.loadNextPage,
  });

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  State<MoviesMasonryWidget> createState() => _MoviesMasonryWidgetState();

  //#endregion
}

class _MoviesMasonryWidgetState extends State<MoviesMasonryWidget> {
  //#region --------------------------------- Variables ---------------------------------

  final ScrollController masonryScrollController = ScrollController();
  bool widgetIsMounted = true;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  @override
  void initState() {
    super.initState();
    masonryScrollController.addListener(() {
      if (masonryScrollController.position.pixels + 100 >=
          masonryScrollController.position.maxScrollExtent) {
        widget.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    masonryScrollController.dispose();
    widgetIsMounted = false;
    super.dispose();
  }

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      controller: masonryScrollController,
      itemCount: widget.movies.length,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        final movie = widget.movies[index];

        if (index == 1) {
          return Column(
            children: [const SizedBox(height: 30), _Movie(movie: movie)],
          );
        }

        return _Movie(movie: movie);
      },
    );
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

    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/app/home/movie/${movie.id}'),
        child: Container(
          width: 150,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MovieImage(image: movie.posterPath),
              const SizedBox(height: 5),
              Text(
                movie.title,
                style: texts.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
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
            return child;
          },
        ),
      ),
    );
  }

  //#endregion
}
