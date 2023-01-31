import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/controllers/favorites/favorites_controller.dart';
import '../../../../utils/mark_as_favorite.dart';
import '../../controller/movie_controller.dart';

class MovieAppBar extends StatelessWidget with PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    final FavoritesController favoritesController = context.watch();

    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
        loaded: (movieState) => [
          favoritesController.state.maybeMap(
            orElse: () => const SizedBox(),
            loaded: (favoritesState) => IconButton(
              key: const Key('favorite-button'),
              onPressed: () => markAsFavorite(
                context: context,
                media: movieState.movie.toMedia(),
                mounted: () => controller.mounted,
              ),
              icon: Icon(
                favoritesState.movies.containsKey(movieState.movie.id)
                    ? Icons.favorite
                    : Icons.favorite_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
