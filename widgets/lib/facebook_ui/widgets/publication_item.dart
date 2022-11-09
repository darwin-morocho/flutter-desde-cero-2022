import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:widgets/facebook_ui/widgets/avatar.dart';
import 'package:widgets/models/publication.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_svg/flutter_svg.dart';

class PublicationItem extends StatelessWidget {
  const PublicationItem({
    Key? key,
    required this.publication,
  }) : super(key: key);
  final Publication publication;

  String _getEmojiPath(Reaction reaction) {
    switch (reaction) {
      case Reaction.like:
        return 'assets/emojis/like.svg';
      case Reaction.love:
        return 'assets/emojis/heart.svg';
      case Reaction.laughing:
        return 'assets/emojis/laughing.svg';
      case Reaction.sad:
        return 'assets/emojis/sad.svg';
      case Reaction.shocking:
        return 'assets/emojis/shocked.svg';
      case Reaction.angry:
        return 'assets/emojis/angry.svg';
    }
  }

  String _formatCount(int value) {
    if (value <= 1000) {
      return value.toString();
    } else {
      return "${(value / 1000).toStringAsFixed(1)}k";
    }
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    );

    const reactions = Reaction.values;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 6,
            color: Color(0xffEBEBEB),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Row(
              children: [
                Avatar(
                  asset: publication.user.avatar,
                  size: 38,
                ),
                const SizedBox(width: 10),
                Text(publication.user.username),
                const Spacer(),
                Text(
                  timeago.format(publication.createdAt),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: publication.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: padding.copyWith(
              top: 15,
            ),
            child: Text(
              publication.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        reactions.length,
                        (index) {
                          final reaction = reactions[index];
                          final isActive = reaction == publication.currentUserReaction;
                          return Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  _getEmojiPath(reaction),
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(height: 3),
                                Icon(
                                  Icons.circle,
                                  color: isActive ? Colors.redAccent : Colors.transparent,
                                  size: 5,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "${_formatCount(publication.commentsCount)} Comments",
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "${_formatCount(publication.sharesCount)} Shares",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
