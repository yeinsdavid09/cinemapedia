import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';

//* Entities
import '../../domain/movies.entity.dart';

class MoviesSliderWidget extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final List<Movie> movies;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const MoviesSliderWidget({super.key, required this.movies});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final colors = Theme.of(context).colorScheme;

    //#endregion

    //#region ----------------------------------- Return ---------------------------------

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Swiper(
        scale: 0.9,
        viewportFraction: 0.8,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary.withAlpha(50),
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return _Movie(movie: movies[index]);
        },
      ),
    );
    //#endregion
  }

  //#endregion
}

class _Movie extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Movie movie;
  BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 10)),
    ],
  );

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  _Movie({required this.movie});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  Widget progressIndicator(ColorScheme colors) {
    return SizedBox.expand(
      child: Center(child: CircularProgressIndicator(color: colors.primary)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final colors = Theme.of(context).colorScheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: boxDecoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) return progressIndicator(colors);
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}
