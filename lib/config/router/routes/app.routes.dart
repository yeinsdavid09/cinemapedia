import 'package:cinemapedia/modules/movies/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Screens
import 'package:cinemapedia/modules/layout/index.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(id: movieId);
          },
        ),
      ],
    ),
  ],
);
