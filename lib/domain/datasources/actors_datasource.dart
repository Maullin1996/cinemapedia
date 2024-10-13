import 'package:cinemapedia/domain/entities/cast.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
