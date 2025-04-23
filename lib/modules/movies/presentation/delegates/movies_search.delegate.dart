import 'dart:async';
import 'package:cinemapedia/config/index.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

//* Entities
import '../../domain/movies.entity.dart';

typedef SearchCallback = Future<List<Movie>> Function({required String query});

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  //#region ----------------------------------- Variables ---------------------------------

  @override
  String get searchFieldLabel => 'Buscar';
  final searchStream = StreamController<List<Movie>>.broadcast();
  final loadingStream = StreamController<bool>.broadcast();
  Timer? _timer;
  final SearchCallback searchCallback;
  List<Movie> initialData;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  MovieSearchDelegate({
    required this.searchCallback,
    required this.initialData,
  });

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  void _onQueryChanged({required String query}) {
    loadingStream.add(true);
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () async {
      final results = await searchCallback(query: query);
      initialData = results;
      searchStream.add(results);
      loadingStream.add(false);
    });
  }

  void _clearStreams() {
    searchStream.close();
  }

  Widget _getStreamBuilder() {
    return StreamBuilder(
      initialData: initialData,
      stream: searchStream.stream,
      builder: (context, snapshot) {
        final suggestions = snapshot.data ?? [];
        return _Results(
          suggestions: suggestions,
          onSuggestionTap: (context, movie) {
            _clearStreams();
            close(context, movie);
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: loadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 1),
              spins: 1,
              infinite: true,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          } else {
            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.close_rounded),
              ),
            );
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _getStreamBuilder();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query: query);
    return _getStreamBuilder();
  }

  //#endregion
}

class _Results extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final List<Movie> suggestions;
  final Function onSuggestionTap;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _Results({required this.suggestions, required this.onSuggestionTap});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return GestureDetector(
          onTap: () => onSuggestionTap(context, suggestion),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SuggestionImage(image: suggestion.posterPath),
                _SuggestionBody(suggestion: suggestion),
              ],
            ),
          ),
        );
      },
    );
  }

  //#endregion
}

class _SuggestionImage extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final String image;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _SuggestionImage({required this.image});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final size = MediaQuery.of(context).size;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SizedBox(
      width: size.width * 0.2,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const Center(child: CircularProgressIndicator());
            }
            return FadeIn(child: child);
          },
          errorBuilder: (context, error, stackTrace) {
            return FadeIn(child: const Placeholder());
          },
        ),
      ),
    );

    //#endregion
  }

  //#endregion
}

class _SuggestionBody extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final Movie suggestion;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _SuggestionBody({required this.suggestion});

  //#endregion

  //#region --------------------------------- Methods ---------------------------------

  @override
  Widget build(BuildContext context) {
    //#region ----------------------------------- Variables ---------------------------------

    final size = MediaQuery.of(context).size;
    final texts = Theme.of(context).textTheme;

    //#endregion

    //#region --------------------------------- Return ---------------------------------

    return SizedBox(
      width: size.width * 0.7,
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            suggestion.title,
            style: texts.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            suggestion.overview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          _SuggestionsRate(
            rate: suggestion.voteAverage,
            popularity: suggestion.popularity,
          ),
        ],
      ),
    );

    //#endregion
  }

  //#endregion
}

class _SuggestionsRate extends StatelessWidget {
  //#region ----------------------------------- Variables ---------------------------------

  final double rate;
  final double popularity;

  //#endregion

  //#region --------------------------------- Hooks ---------------------------------

  const _SuggestionsRate({required this.rate, required this.popularity});

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
            NumbersPipe.formatNumber(rate.toInt(), 1),
            style: texts.bodySmall?.copyWith(color: Colors.yellow.shade800),
          ),
          const Spacer(),
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
