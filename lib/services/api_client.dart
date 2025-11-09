import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/movie.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/movie/popular')
  Future<MoviesResponse> getPopularMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page, {
    @Query('language') String language = 'en-US',
  });

  @GET('/movie/top_rated')
  Future<MoviesResponse> getTopRatedMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page, {
    @Query('language') String language = 'en-US',
  });

  @GET('/movie/upcoming')
  Future<MoviesResponse> getUpcomingMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page, {
    @Query('language') String language = 'en-US',
  });

  @GET('/search/movie')
  Future<MoviesResponse> searchMovies(
    @Query('api_key') String apiKey,
    @Query('query') String query,
    @Query('page') int page, {
    @Query('language') String language = 'en-US',
  });

  @GET('/movie/{movieId}')
  Future<Movie> getMovieDetails(
    @Path('movieId') int movieId,
    @Query('api_key') String apiKey, {
    @Query('language') String language = 'en-US',
  });
}
