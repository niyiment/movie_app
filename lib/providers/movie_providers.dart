// API Client Provider
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_app/app/env.dart';
import 'package:movie_app/repositories/movie_repository.dart';

import '../models/movie.dart';
import '../services/api_client.dart';



final dioProvider = Provider<Dio>((ref) {
  return Dio()
    ..options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});

// Repository Provider
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MovieRepository(apiClient: apiClient, apiKey: Env.tdbmiApiKey);
});

class PopularMoviesPageNotifier extends Notifier<int> {
    @override
    int build() => 1;

    void nextPage() => state++;
    void previousPage() => state--;
    void setPage(int page) => state = page;
    void reset() => state = 1;
}

class TopRatePageNotifier extends Notifier<int> {
  @override
  int build() => 1;

  void nextPage() => state++;
  void previousPage() => state--;
  void setPage(int page) => state = page;
  void reset() => state = 1;
}

class UpcomingPageNotifier extends Notifier<int> {
  @override
  int build() => 1;

  void nextPage() => state++;
  void previousPage() => state--;
  void setPage(int page) => state = page;
  void reset() => state = 1;
}

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
  void clear() => state = '';
}

// State Notifiers for pagination
final popularMoviesPageProvider = NotifierProvider<PopularMoviesPageNotifier, int>(PopularMoviesPageNotifier.new);
final topRatedPageProvider = NotifierProvider<TopRatePageNotifier, int>(TopRatePageNotifier.new);
final upcomingPageProvider = NotifierProvider<UpcomingPageNotifier, int>(UpcomingPageNotifier.new);
final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);


// Movies Providers
final popularMoviesProvider = FutureProvider.family<MoviesResponse, int>((
  ref,
  page,
) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getPopularMovies(page);
});

final topRatedMoviesProvider = FutureProvider.family<MoviesResponse, int>((
  ref,
  page,
) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getTopRatedMovies(page);
});

final upcomingMoviesProvider = FutureProvider.family<MoviesResponse, int>((
  ref,
  page,
) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getUpcomingMovies(page);
});

final searchMoviesProvider =
    FutureProvider.family<MoviesResponse, (String, int)>((ref, params) async {
      final (query, page) = params;
      final repository = ref.watch(movieRepositoryProvider);
      return repository.searchMovies(query, page);
    });

final movieDetailsProvider = FutureProvider.family<Movie, int>((
  ref,
  movieId,
) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getMovieDetails(movieId);
});

