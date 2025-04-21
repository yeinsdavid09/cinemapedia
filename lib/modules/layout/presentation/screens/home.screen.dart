import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Providers
import '../../providers/initial_loading.provider.dart';

//* Widgets
import '../widgets/app_bar.widget.dart';
import '../widgets/app_navigation_bar.widget.dart';
import '../widgets/app_loader.widget.dart';

//* Movies
import 'package:cinemapedia/modules/movies/index.dart';

class HomeScreen extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  static const String routeName = 'home_screen';

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const HomeScreen({super.key});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(floating: true, flexibleSpace: AppBarWidget()),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _HomeView();
              }, childCount: 1),
            ),
          ],
        ),
        bottomNavigationBar: AppNavigationBarWidget(),
      ),
    );
  }

  //#endregion
}

class _HomeView extends ConsumerStatefulWidget {
  //#region --------------------------------- Hooks ---------------------------------

  const _HomeView();

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  _HomeViewState createState() => _HomeViewState();

  //#endregion
}

class _HomeViewState extends ConsumerState<_HomeView> {
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

  //#region ----------------------------------- Methods ---------------------------------

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

  //#endregion
}
