
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/movie_providers.dart';
import '../widgets/movie_card.dart';


class SearchResultsScreen extends ConsumerStatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  ConsumerState<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final searchAsync = ref.watch(
      searchMoviesProvider((widget.query, _currentPage)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Results for "${widget.query}"'),
        elevation: 0,
      ),
      body: searchAsync.when(
        data: (data) => data.results.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_off, size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No movies found',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 2 : 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: data.results.length,
                      itemBuilder: (context, index) =>
                          MovieCard(movie: data.results[index]),
                    ),
                  ),
                  if (data.totalPages > 1)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _currentPage > 1
                                ? () {
                                    setState(() => _currentPage--);
                                  }
                                : null,
                            child: const Text('Previous'),
                          ),
                          Text(
                            'Page $_currentPage of ${data.totalPages}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          ElevatedButton(
                            onPressed: _currentPage < data.totalPages
                                ? () {
                                    setState(() => _currentPage++);
                                  }
                                : null,
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.deepPurple),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading search results',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

