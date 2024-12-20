import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorie(Movie movie);

  Future<bool> isMovieFavorites(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
