
import '../models/movie.dart';
import '../services/api_client.dart';

class MovieRepository {
  final ApiClient apiClient;
  final String apiKey;

  MovieRepository({required this.apiClient, required this.apiKey});

  Future<MoviesResponse> getPopularMovies(int page) =>
      apiClient.getPopularMovies(apiKey, page);

  Future<MoviesResponse> getTopRatedMovies(int page) =>
      apiClient.getTopRatedMovies(apiKey, page);

  Future<MoviesResponse> getUpcomingMovies(int page) =>
      apiClient.getUpcomingMovies(apiKey, page);

  Future<MoviesResponse> searchMovies(String query, int page) =>
      apiClient.searchMovies(apiKey, query, page);

  Future<Movie> getMovieDetails(int movieId) =>
      apiClient.getMovieDetails(movieId, apiKey);
}

