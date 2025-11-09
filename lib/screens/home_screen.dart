import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/movie_providers.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: const Color(0xFF0F0F1E),
            elevation: 0,
            title: const Text(
              'Movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SearchBarWidget(),
                  ),
                  const SizedBox(height: 12),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Popular'),
                      Tab(text: 'Top Rated'),
                      Tab(text: 'Upcoming'),
                    ],
                    indicatorColor: Colors.deepPurple,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMovieGrid(ref, 'popular', isMobile),
                _buildMovieGrid(ref, 'topRated', isMobile),
                _buildMovieGrid(ref, 'upcoming', isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieGrid(WidgetRef ref, String category, bool isMobile) {
    final page = category == 'popular'
        ? ref.watch(popularMoviesPageProvider)
        : category == 'topRated'
        ? ref.watch(topRatedPageProvider)
        : ref.watch(upcomingPageProvider);

    final moviesAsync = category == 'popular'
        ? ref.watch(popularMoviesProvider(page))
        : category == 'topRated'
        ? ref.watch(topRatedMoviesProvider(page))
        : ref.watch(upcomingMoviesProvider(page));

    return moviesAsync.when(
      data: (data) => _MovieGridView(
        movies: data.results,
        category: category,
        isMobile: isMobile,
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
              'Error loading movies',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieGridView extends ConsumerWidget {
  final List movies;
  final String category;
  final bool isMobile;

  const _MovieGridView({
    required this.movies,
    required this.category,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crossAxisCount = isMobile ? 2 : 3;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) => MovieCard(movie: movies[index]),
    );
  }
}
