import 'package:cinemapedia/modules/layout/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Widgets
import '../widgets/app_bar.widget.dart';

//* Movies
import 'package:cinemapedia/modules/movies/index.dart';

class HomeScreen extends ConsumerStatefulWidget {
  //#region ----------------------------------- Variables ---------------------------------

  static const String routeName = 'home_screen';

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();

  //#endregion
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  //#region --------------------------------- Hooks ---------------------------------

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final nowPlayingMovies = ref.watch(moviesSliderProvider);

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarWidget(),
            MoviesSliderWidget(movies: nowPlayingMovies),
          ],
        ),
        bottomNavigationBar: AppNavigationBarWidget(),
      ),
    );

    //#endregion
  }

  //#endregion
}
