import 'package:flutter/material.dart';

import '../../../../global/controllers/favorites/state/favorites_state.dart';
import 'favorites_list.dart';

class FavoritesContent extends StatelessWidget {
  const FavoritesContent({
    super.key,
    required this.state,
    required this.tabController,
  });
  final FavoritesStateLoaded state;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        FavoritesList(
          items: state.movies.values.toList(),
        ),
        FavoritesList(
          items: state.series.values.toList(),
        ),
      ],
    );
  }
}
