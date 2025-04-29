import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Providers
import '../../providers/initial_loading.provider.dart';

//* Widgets
import '../widgets/app_bar.widget.dart';
import '../widgets/app_loader.widget.dart';

//* Movies
import 'package:cinemapedia/modules/movies/index.dart';

class HomeView extends StatelessWidget {
  //#region --------------------------------- Hooks ---------------------------------

  const HomeView({super.key});

  //#endregion

  //#region ----------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverAppBar(floating: true, flexibleSpace: AppBarWidget()),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return const _HomeSections();
          }, childCount: 1),
        ),
      ],
    );
  }

  //#endregion
}

class _HomeSections extends ConsumerStatefulWidget {
  //#region ----------------------------------- Hooks ---------------------------------

  const _HomeSections();

  //#endregion

  //#region ----------------------------------- Methods ---------------------------------

  @override
  _HomeSectionsState createState() => _HomeSectionsState();

  //#endregion
}

class _HomeSectionsState extends ConsumerState<_HomeSections> {
  //#region ----------------------------------- Hooks ---------------------------------

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  //#endregion
  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return AppLoader();

    final moviesSlider = ref.watch(moviesSliderProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    //#endregion

    //#region ----------------------------------- Return ---------------------------------

    return Column(
      spacing: 10,
      children: [
        MoviesSliderWidget(movies: moviesSlider),
        MoviesHorizontalListWidget(
          movies: nowPlayingMovies,
          title: 'En Cines',
          subtitle: 'Lunes 20',
          loadNextPage: () {
            ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
          },
        ),
        MoviesHorizontalListWidget(
          movies: upcomingMovies,
          title: 'Proximamente',
          loadNextPage: () {
            ref.read(upcomingMoviesProvider.notifier).loadNextPage();
          },
        ),
        MoviesHorizontalListWidget(
          movies: popularMovies,
          title: 'Populares',
          loadNextPage: () {
            ref.read(popularMoviesProvider.notifier).loadNextPage();
          },
        ),
        MoviesHorizontalListWidget(
          movies: topRatedMovies,
          title: 'Mejor Calificadas',
          loadNextPage: () {
            ref.read(topRatedMoviesProvider.notifier).loadNextPage();
          },
        ),
      ],
    );

    //#endregion
  }
}
