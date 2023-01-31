import 'package:flutter/material.dart';

import '../../../../../../domain/models/media/media.dart';
import '../../../../../global/utils/get_image_url.dart';
import '../../../../../global/widgets/network_image.dart';
import '../../../../../utils/go_to_media_details.dart';

class TrendingTile extends StatelessWidget {
  const TrendingTile({
    super.key,
    required this.media,
    required this.width,
    this.showData = true,
  });
  final Media media;
  final double width;
  final bool showData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToMediaDetails(context, media),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: MyNetworkImage(
                  url: getImageUrl(media.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
              if (showData)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Opacity(
                    opacity: 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Chip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          label: Text(
                            media.voteAverage.toStringAsFixed(1),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Chip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          label: Icon(
                            media.type == MediaType.movie
                                ? Icons.movie
                                : Icons.tv,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
