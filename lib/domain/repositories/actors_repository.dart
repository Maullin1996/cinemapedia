import 'package:cinemapedia/domain/entities/cast.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
