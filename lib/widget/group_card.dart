import 'package:flutter/material.dart';
import 'package:vibe_app/screens/models/groups.dart';

class GroupCard extends StatefulWidget {
  final GroupModel group;
  const GroupCard({super.key, required this.group});

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // dense: true,
          horizontalTitleGap: 10,
          leading: widget.group.profilePicture.isNotEmpty
              ? CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    widget.group.profilePicture,
                  ),
                )
              : const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(
                    'assets/icons/group_icon.jpeg',
                  ),
                ),
          title: Text(
            widget.group.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text("${widget.group.totalMembers} Members"),
        ),
        const Divider(
          thickness: 0.5,
        )
      ],
    );
  }
}
