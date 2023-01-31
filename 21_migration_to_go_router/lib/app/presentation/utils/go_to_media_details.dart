import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/media/media.dart';
import '../routes/routes.dart';

void goToMediaDetails(BuildContext context, Media media) async {
  if (media.type == MediaType.movie) {
    context.pushNamed(
      Routes.movie,
      params: {
        'id': media.id.toString(),
      },
    );
  }
}
