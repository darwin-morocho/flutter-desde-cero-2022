import 'package:flutter/material.dart';

import '../../domain/models/media/media.dart';
import '../modules/movie/views/movie_view.dart';

Future<void> goToMediaDetails(BuildContext context, Media media) async {
  if (media.type == MediaType.movie) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieView(
          movieId: media.id,
        ),
      ),
    );
  }
}
