import 'package:flutter/material.dart';
import 'package:vibe_app/screens/models/community.dart';

class CommunityCard extends StatefulWidget {
  final CommunityModel community;
  const CommunityCard({super.key, required this.community});

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                image: widget.community.profilePicture.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(
                          widget.community.profilePicture,
                        ),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage(
                          'assets/icons/community_icon.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.community.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "${widget.community.totalGroups} Groups",
                ),
                Text(
                  "${widget.community.totalMembers} Members",
                ),
              ],
            ),
          ],
        ),
        const Divider(
          thickness: 0.5,
        )
      ],
    );
  }
}
