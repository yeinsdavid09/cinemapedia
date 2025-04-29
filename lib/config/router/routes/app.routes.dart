import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Screens
import 'package:cinemapedia/modules/layout/index.dart';
import 'package:cinemapedia/modules/movies/index.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/app/:view',
      name: LayoutScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        final view = state.pathParameters['view'] ?? 'home';
        return LayoutScreen(currentView: view);
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
    GoRoute(path: '/', redirect: (_, __) => '/app/home'),
  ],
);
