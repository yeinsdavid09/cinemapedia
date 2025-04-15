import 'package:cinemapedia/modules/movies/providers/movies.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: ListView.builder(
          itemCount: nowPlayingMovies.length,
          itemBuilder: (context, index) {
            final movie = nowPlayingMovies[index];
            return ListTile(title: Text(movie.title));
          },
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}
