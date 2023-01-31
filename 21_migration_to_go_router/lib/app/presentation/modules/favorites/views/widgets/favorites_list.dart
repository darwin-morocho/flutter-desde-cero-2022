import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media.dart';
import '../../../../global/utils/get_image_url.dart';
import '../../../../global/widgets/network_image.dart';
import '../../../../utils/go_to_media_details.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key, required this.items});
  final List<Media> items;

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (_, index) {
        final item = widget.items[index];

        return MaterialButton(
          key: Key('${item.type.name}-${item.id}'),
          onPressed: () => goToMediaDetails(context, item),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              MyNetworkImage(
                url: getImageUrl(
                  item.posterPath,
                ),
                width: 60,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: widget.items.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
