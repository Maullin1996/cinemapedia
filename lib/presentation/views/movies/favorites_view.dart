import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

//init state
//sólo las primeras 10

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();

    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> favoriteMovies =
        ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
        body: ListView.builder(
      itemCount: favoriteMovies.length,
      itemBuilder: (context, index) {
        final movie = favoriteMovies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    ));
  }
}
