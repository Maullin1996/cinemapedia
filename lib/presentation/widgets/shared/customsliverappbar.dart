import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorites(movieId);
});

class CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {
              ref.watch(localStorageRepositoryProvider).toggleFavorie(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
              data: (isFavorite) => isFavorite
                  ? Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                  : Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(strokeWidth: 2),
            ))
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.2],
                colors: [Colors.black12, Colors.transparent]),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.8, 1.0],
                colors: [Colors.transparent, Colors.black54]),
            const _CustomGradient(
                begin: Alignment.topLeft,
                stops: [0.0, 0.3],
                colors: [Colors.black87, Colors.transparent]),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.colors = const [Colors.black87, Colors.transparent],
      this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      this.stops = const [0.0, 1.0]});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, stops: stops, colors: colors),
        ),
      ),
    );
  }
}
